//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/21/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                HomeView().tabItem {
                    Label("Calculate", systemImage: "house")
                }
                
                InfoView().tabItem {
                    Label("Info", systemImage: "info")
                }
                
                StatusView().tabItem {
                    Label("Status", systemImage: "checkmark.seal")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
