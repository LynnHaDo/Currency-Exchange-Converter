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
            
            // Content
            VStack {
                // Title
                Text("Information")
                    .font(Font.custom("HostGrotesk-Bold", size: 24, relativeTo: .title))
                    .foregroundStyle(.text)
            }
        }
    }
}
