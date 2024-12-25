//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/21/24.
//

import SwiftUI

struct ContentView: View {
    var statusIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @State var isDataAvailable: Bool = false
    @State var errorObj: ErrorModel?
    
    @State var currencies: [CurrencyModel]?
    
    // Get all the available currencies
    func getCurrencies()  {
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
    
    var body: some View {
        ZStack {
            TabView {
                HomeView().tabItem {
                    Label("Calculate", systemImage: "house")
                }
                
                InfoView(currencies: self.currencies,
                         isCurrencyDataAvailable: self.isDataAvailable,
                         errorObj: self.errorObj).tabItem {
                    Label("Info", systemImage: "info")
                }
                
                StatusView().tabItem {
                    Label("Status", systemImage: "checkmark.seal")
                }
            }
        }
        .onAppear() {
            getCurrencies()
        }
    }
}

#Preview {
    ContentView()
}
