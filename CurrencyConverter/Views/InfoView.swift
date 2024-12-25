//
//  InfoView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct InfoView: View {
    
    var body: some View {
        ZStack {
            // Background color
            Color.pastelGreen.ignoresSafeArea()
            
            VStack {
                // Display current rates
                RatesView()
                
                // Display available currencies
                CurrenciesView()
            }
        }
        
    }
}

#Preview {
    InfoView()
}
