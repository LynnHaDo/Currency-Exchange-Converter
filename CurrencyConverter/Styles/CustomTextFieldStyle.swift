//
//  CustomTextFieldStyle.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/24/24.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(.greenishWhite)
            .foregroundStyle(.text)
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6)
                .stroke(.text, lineWidth: 2))
            .font(Font.custom("HostGrotesk-Regular", size: 18, relativeTo: .body))
    }
}
