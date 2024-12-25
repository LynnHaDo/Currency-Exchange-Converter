//
//  InfoView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct InfoView: View {
    
    var statusIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @State var isDataAvailable: Bool = false
    @State var errorObj: ErrorModel?
    @State var currencies: [CurrencyModel]?
    
    // Get all the available currencies
    func getCurrencies() {
        statusIndicator.startAnimating()
        
        let url = Routes.currenciesUrl
        
        APIService.fetchData(urlString: url) {
            (response: [CurrencyModel]?, error: ErrorModel?) in
            
            if let error = error {
                self.errorObj = ErrorModel(code: error.code, message: error.message)
            }
            
            if !response!.isEmpty {
                self.isDataAvailable = true
                self.currencies = response
            }
            
            self.statusIndicator.dismissLoader()
        }
    }
    
    @ViewBuilder
    var body: some View {
        ZStack {
            // Background color
            Color.pastelGreen.ignoresSafeArea()
            
            // Content
            VStack {
                if !isDataAvailable {
                    HStack {
                        Spacer()
                        
                        VStack {
                            if (errorObj != nil)
                            {
                                Text("An error occurred: \(errorObj!.code)").title()
                                Text(errorObj!.message).regular()
                            }
                            else {
                                Text("An error occurred").title()
                                Text("Please try again later.").regular()
                            }
                        }
                        
                        Spacer()
                    }
                }
                else {
                    // Title
                    Text("Supported currencies").title().padding(10)
                    
                    // Display all currencies
                    ScrollView {
                        ForEach(0..<currencies!.count, id: \.self) { idx in
                            CurrencyRowView(symbol: currencies![idx].symbol,
                                            description: currencies![idx].description)
                        }
                    }
                    .frame(maxHeight: 400)
                }
            }
        }
        .onAppear() {
            getCurrencies()
        }
    }
}

struct CurrencyRowView: View {
    let symbol: String
    let description: String
    
    var body: some View {
        GeometryReader { metrics in
            HStack {
                Spacer().frame(width: metrics.size.width * 0.1)
                Text(symbol).frame(width: metrics.size.width * 0.2, alignment: .leading)
                Spacer().frame(width: metrics.size.width * 0.1)
                Text(description).frame(width: metrics.size.width * 0.6, alignment: .leading)
            }
        }
        .padding(5)
    }
}

#Preview {
    InfoView()
}
