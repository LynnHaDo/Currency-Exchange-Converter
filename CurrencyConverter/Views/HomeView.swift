//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct HomeView: View {
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
                Text("Currency Converter")
                    .font(Font.custom("HostGrotesk-Bold", size: 24, relativeTo: .title))
                    .foregroundStyle(.text)
                
                // Conversion input
                HStack {
                    // Left side: Input
                    VStack {
                        // Currency
                        
                        // Textfield
                    }
                    // Equal
                    // Right side: Output
                    VStack {
                        // Currency
                        
                        // Textfield
                    }
                }
            }
        }
    }
}
