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
    @State var rates: [RateItem]?
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // Get all the available rates
    func getRatesByDate(dateString: String) {
        statusIndicator.startAnimating()
        
        let url = Routes.historyDetailsUrl + "&date=\(dateString)"
        
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
            
            Text("Date: \(convertDateToString(date: selectedDate)) | Base currency: EUR")
                .regular().padding(10)
            
            // Date selector
            HStack {
                Spacer()
                DatePicker(selection: $selectedDate,
                           in: ...Date.now,
                           displayedComponents: .date)
                {
                    Text("Select a date")
                }
                .frame(width: 300)
                .onChange(of: selectedDate) {
                    getRatesByDate(dateString: convertDateToString(date: selectedDate))
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
            }
            else {
                // Display all rates
                if (rates!.count == 0)
                {
                    VStack {
                        Text("No rates available on this date.").regular().padding(10)
                        Text("Please select another date.").caption()
                    }
                    .multilineTextAlignment(.center)
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
                }
            }
        }
        .onAppear() {
            getRatesByDate(dateString: convertDateToString(date: selectedDate))
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
        .frame(height: 35)
    }
}
