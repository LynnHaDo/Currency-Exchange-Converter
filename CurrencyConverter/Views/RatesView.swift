//
//  RatesView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/24/24.
//

import SwiftUI

struct RatesView: View {
    var statusIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @State var isDataAvailable: Bool = false
    @State var errorObj: ErrorModel?
    @State var selectedDate: Date = Date.now
    @State var selectedBaseCurrency: String = "EUR"
    @State var rates: [RateItem]?
    
    let currencies: [CurrencyModel]?
    let isCurrencyDataAvailable: Bool
    let currencyErrorObj: ErrorModel?
    
    // Get all the available rates
    func getRates(dateString: String, baseCurrency: String) {
        statusIndicator.startAnimating()
        
        let url = Routes.historyDetailsUrl + "&base_currency=\(baseCurrency)&date=\(dateString)"
        
        APIService.fetchData(urlString: url) {
            (response: HistoryDetailsModel?, error: ErrorModel?) in
            
            if let error = error {
                self.errorObj = ErrorModel(code: error.code, message: error.message)
            }
            
            if let res = response {
                self.isDataAvailable = true
                self.rates = res.rates
            }
            
            self.statusIndicator.dismissLoader()
        }
    }
    
    var body: some View {
        VStack {
            // Title
            Text("Rates").title().padding(10)
            
            Text("Date: \(StringFormatters.convertDateToString(date: selectedDate))")
                .regular().padding(5)
            
            Text("Base currency: \(selectedBaseCurrency)")
                .regular().padding(10)
            
            // Selectors
            HStack {
                Spacer()
                
                VStack {
                    // Pick a date to retrieve currency rates from
                    DatePicker(selection: $selectedDate,
                               in: ...Date.now,
                               displayedComponents: .date)
                    {
                        Text("Select a date")
                    }
                    .onChange(of: selectedDate) {
                        getRates(dateString: StringFormatters.convertDateToString(date: selectedDate),
                                 baseCurrency: selectedBaseCurrency.lowercased())
                    }
                    
                    if (isCurrencyDataAvailable && !self.currencies!.isEmpty) {
                        Picker("Select the base currency", selection: $selectedBaseCurrency) {
                            ForEach(0..<currencies!.count, id: \.self) { idx in
                                Text(currencies![idx].description).tag(currencies![idx].symbol)
                            }
                        }
                        .onChange(of: selectedBaseCurrency) {
                            getRates(dateString: StringFormatters.convertDateToString(date: selectedDate),
                                     baseCurrency: selectedBaseCurrency.lowercased())
                        }
                    }
                }
                
                Spacer()
            }
            
            // View all rates
            if !isDataAvailable {
                HStack {
                    Spacer()
                    
                    VStack {
                        if (errorObj != nil)
                        {
                            Text("An error occurred: \(errorObj!.code)").regular()
                            Text(errorObj!.message).caption()
                        }
                        else {
                            Text("An error occurred").regular()
                            Text("Please try again later.").caption()
                        }
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
            else {
                // Display all rates
                if (rates!.count == 0)
                {
                    ErrorMessageView(errorObj: ErrorModel(code: "400",
                                                          message: "No rates available on this date or with this currency. Please select another date or currency."))
                }
                else {
                    ScrollView {
                        ForEach(0..<rates!.count, id: \.self) { idx in
                            RatesRowView(symbol: rates![idx].symbol,
                                         currency: rates![idx].currency,
                                         value: rates![idx].value)
                        }
                    }
                    .list()
                    .contentMargins([.top, .bottom], 20)
                }
            }
        }
        .frame(width: 350)
        .onAppear() {
            getRates(dateString: StringFormatters.convertDateToString(date: selectedDate),
                     baseCurrency: selectedBaseCurrency.lowercased())
        }
    }
}

struct RatesRowView: View {
    let symbol: String
    let currency: String
    let value: Double
    
    var body: some View {
        GeometryReader { metrics in
            HStack {
                Spacer().frame(width: metrics.size.width * 0.1)
                Text(symbol).frame(width: metrics.size.width * 0.2, alignment: .leading)
                Spacer().frame(width: metrics.size.width * 0.05)
                Text(currency).frame(width: metrics.size.width * 0.3, alignment: .leading)
                Spacer().frame(width: metrics.size.width * 0.05)
                Text(String(format: "%.2f", value)).frame(width: metrics.size.width * 0.3, alignment: .leading)
            }
        }
        .frame(width: 350, height: 35)
    }
}
