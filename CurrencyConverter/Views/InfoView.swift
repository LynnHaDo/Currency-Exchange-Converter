//
//  InfoView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct InfoView: View {
    
    let currencies: [CurrencyModel]?
    let isCurrencyDataAvailable: Bool
    let errorObj: ErrorModel?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.pastelGreen.ignoresSafeArea()
                
                VStack {
                    // Display current rates
                    RatesView(currencies: self.currencies,
                              isCurrencyDataAvailable: self.isCurrencyDataAvailable,
                              currencyErrorObj: self.errorObj)
                    
                    // Display available currencies
                    CurrenciesView(currencies: self.currencies,
                                   isDataAvailable: self.isCurrencyDataAvailable,
                                   errorObj: self.errorObj)
                }
            }
        }
        .pickerStyle(.navigationLink)
    }
}
