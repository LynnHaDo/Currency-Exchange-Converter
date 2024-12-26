//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct HomeView: View {
    var statusIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @State var selectedDate: Date = Date.now
    @State var leftAmt = ""
    @State var leftCurrency: String = "EUR"
    @FocusState var leftTyping
    @State var rightAmt = ""
    @State var rightCurrency: String = "USD"
    @FocusState var rightTyping
    @State var conversionErrorObj: ErrorModel?
    
    let isCurrencyDataAvailable: Bool
    let currencies: [CurrencyModel]?
    let errorObj: ErrorModel?
    
    // Get conversion result
    func getConversionResult(from inputCurrency: String,
                             to outputCurrency: String,
                             amount: String,
                             date ratesDate: Date,
                             side inputSide: Bool) {
        
        guard StringFormatters.isStringValidNumber(amount) else { return }
        
        statusIndicator.startAnimating()
        
        let dateStr = StringFormatters.convertDateToString(date: ratesDate)
        
        let url = Routes.convertDetailsUrl + "&from=\(inputCurrency)&currencies=\(outputCurrency)&amount=\(amount)&date=\(dateStr)"
        
        APIService.fetchData(urlString: url) {
            (response: ConversionDetailsModel?, error: ErrorModel?) in
            
            if let error = error {
                self.conversionErrorObj = error
                clearAll()
            }
            
            if response != nil && !response!.rates.isEmpty {
                self.conversionErrorObj = nil
                let result = StringFormatters.doubleToString(number: response!.rates.first!.value)
                if (inputSide) {
                    self.rightAmt = result
                }
                else {
                    self.leftAmt = result
                }
            }
            else {
                self.conversionErrorObj = ErrorModel(code: "400",
                                                     message: "Rates unavailable for the selected date and currencies. Please select another date/currencies.")
                clearAll()
            }
            
            self.statusIndicator.dismissLoader()
        }
    }
    
    // Clear all fields
    func clearAll() {
        self.leftAmt = ""
        self.rightAmt = ""
    }
    
    // Set the right side amount
    func setRight() {
        getConversionResult(from: leftCurrency.lowercased(),
                            to: rightCurrency.lowercased(),
                            amount: leftAmt,
                            date: selectedDate,
                            side: true)
    }
    
    // Set the left side amount
    func setLeft() {
        getConversionResult(from: rightCurrency.lowercased(),
                            to: leftCurrency.lowercased(),
                            amount: rightAmt,
                            date: selectedDate,
                            side: false)
    }
    
    // Swap the left and right sides 
    func swap() {
        // Swap the values
        let tempAmt: String = leftAmt
        leftAmt = rightAmt
        rightAmt = tempAmt
        
        // Swap the currencies
        let tempCurrency: String = leftCurrency
        leftCurrency = rightCurrency
        rightCurrency = tempCurrency
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.pastelGreen.ignoresSafeArea()
                
                // Content
                VStack {
                    // Logo
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                    
                    // Title
                    Text("Currency Converter").title()
                    
                    if (isCurrencyDataAvailable && !self.currencies!.isEmpty) {
                        DatePicker(selection: $selectedDate,
                                   in: ...Date.now,
                                   displayedComponents: .date)
                        {
                            Text("Date")
                        }
                        
                        Picker("Select the left currency", selection: $leftCurrency) {
                            ForEach(0..<currencies!.count, id: \.self) { idx in
                                Text(currencies![idx].description).tag(currencies![idx].symbol)
                            }
                        }
                        
                        Picker("Select the right currency", selection: $rightCurrency) {
                            ForEach(0..<currencies!.count, id: \.self) { idx in
                                Text(currencies![idx].description).tag(currencies![idx].symbol)
                            }
                        }
                    }
                    else {
                        ErrorMessageView(errorObj: errorObj)
                    }
                    // Conversion
                    HStack {
                        Spacer()
                        
                        // Left side: Input
                        VStack {
                            // Currency
                            Text(leftCurrency).regular().padding(10)
                            
                            // Textfield
                            TextField("Left amount",
                                      text: $leftAmt)
                                .textFieldStyle(CustomTextFieldStyle())
                                .focused($leftTyping)
                        }
                        
                        // Swap
                        Image(.exchange)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .foregroundColor(.text)
                            .onTapGesture {
                                swap()
                            }
                        
                        // Right side: Output
                        VStack {
                            // Currency
                            Text(rightCurrency).regular().padding(10)
                            
                            // Textfield
                            TextField("Right amount", text: $rightAmt)
                                .textFieldStyle(CustomTextFieldStyle())
                                .multilineTextAlignment(.trailing)
                                .focused($rightTyping)
                        }
                        
                        Spacer()
                    }.padding([.top, .bottom], 25)
                    
                    if (conversionErrorObj != nil) {
                        ErrorMessageView(errorObj: conversionErrorObj)
                    }
                }
                .onChange(of: leftAmt) {
                    if (leftTyping) {
                        setRight()
                        rightAmt = leftAmt == "" ? "" : rightAmt
                    }
                }
                .onChange(of: rightAmt) {
                    if (rightTyping) {
                        setLeft()
                        leftAmt = rightAmt == "" ? "" : leftAmt
                    }
                }
                .onChange(of: selectedDate) {
                    conversionErrorObj = nil
                    
                    if (leftTyping)
                    {
                        setRight()
                    }
                    else
                    {
                        setLeft()
                    }
                }
                .onChange(of: leftCurrency) {
                    setLeft()
                }
                .onChange(of: rightCurrency) {
                    setRight()
                }
                .frame(width: 350)
            }
        }
        .pickerStyle(.navigationLink)
    }
}
