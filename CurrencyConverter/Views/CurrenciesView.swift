//
//  CurrenciesView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/24/24.
//

import SwiftUI

struct CurrenciesView: View {
    
    let currencies: [CurrencyModel]?
    let isDataAvailable: Bool
    let errorObj: ErrorModel?
    
    @ViewBuilder
    var body: some View {
        VStack {
            if !isDataAvailable {
                HStack {
                    Spacer()
                    ErrorMessageView(errorObj: errorObj)
                    Spacer()
                }
            }
            else {
                // Title
                Text("Supported currencies").title().contentMargins(.bottom, 30)
                
                // Display all currencies
                ScrollView {
                    ForEach(0..<currencies!.count, id: \.self) { idx in
                        CurrencyRowView(symbol: currencies![idx].symbol,
                                        description: currencies![idx].description)
                    }
                }
                .list() 
            }
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
        .frame(width: 350, height: 35)
    }
}
