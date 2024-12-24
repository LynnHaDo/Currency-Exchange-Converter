//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct HomeView: View {
    @State var leftAmt = ""
    @State var rightAmt = ""
    
    var body: some View {
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
                
                // Conversion input
                HStack {
                    Spacer()
                    
                    // Left side: Input
                    VStack {
                        // Currency
                        
                        // Textfield
                        TextField("Input", text: $leftAmt)
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
                        
                        // Textfield
                        TextField("Output", text: $rightAmt)
                            .textFieldStyle(CustomTextFieldStyle())
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Spacer()
                }.padding(25)
            }
        }
    }
}
