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
    @State var rightAmt = ""
    @State var rightCurrency: String = "USD"
    @State var conversionErrorObj: ErrorModel?
    
    let isCurrencyDataAvailable: Bool
    let currencies: [CurrencyModel]?
    let errorObj: ErrorModel?
    
    // Get conversion result
    func getConversionResult(from: String, to: String, amount: String, date: Date) {
        statusIndicator.startAnimating()
        
        let dateStr = StringFormatters.convertDateToString(date: date)
        
        let url = Routes.convertDetailsUrl + "&from=\(from)&currencies=\(to)&amount=\(amount)&date=\(dateStr)"
        
        APIService.fetchData(urlString: url) {
            (response: ConversionDetailsModel?, error: ErrorModel?) in
            
            if let error = error {
                self.conversionErrorObj = error
            }
            
            if response != nil && !response!.rates.isEmpty {
                self.conversionErrorObj = nil 
                rightAmt = StringFormatters.doubleToString(number: response!.rates.first!.value)
            }
            else {
                self.conversionErrorObj = ErrorModel(code: "400",
                                                     message: "Rates unavailable for the selected date and currencies. Please select another date/currencies.")
            }
            
            self.statusIndicator.dismissLoader()
        }
        
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
                                
                        }
                        // Equal
                        Image(.exchange)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .foregroundColor(.text)
                        
                        // Right side: Output
                        VStack {
                            // Currency
                            Text(rightCurrency).regular().padding(10)
                            
                            // Textfield
                            TextField("Right amount", text: $rightAmt)
                                .textFieldStyle(CustomTextFieldStyle())
                                .multilineTextAlignment(.trailing)
                                .disabled(true)
                        }
                        
                        Spacer()
                    }.padding([.top, .bottom], 25)
                    
                    Button("Calculate") {
                        getConversionResult(from: leftCurrency.lowercased(),
                                            to: rightCurrency.lowercased(),
                                            amount: leftAmt,
                                            date: selectedDate)
                    }
                    .disabled(!StringFormatters.isStringValidNumber(numString: leftAmt))
                    .buttonStyle(PrimaryButton())
                    .padding(25)
                    
                    if (conversionErrorObj != nil) {
                        ErrorMessageView(errorObj: conversionErrorObj)
                    }
                }
                .frame(width: 350)
            }
        }
        .pickerStyle(.navigationLink)
    }
}
