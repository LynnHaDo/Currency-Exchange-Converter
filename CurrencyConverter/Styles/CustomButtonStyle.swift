//
//  CustomButtonStyle.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/25/24.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
         configuration.label.padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 15)
                            .font(Font.custom("HostGrotesk-Bold", size: 18, relativeTo: .body))
                            .foregroundStyle(.greenishWhite)
                            .background(.accent)
                            .cornerRadius(6)
                            .scaleEffect(configuration.isPressed ? 1.1 : 1)
                            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
