//
//  TextView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/24/24.
//

import SwiftUI

extension Text {
    func title() -> some View {
        self.font(Font.custom("HostGrotesk-Bold", size: 24, relativeTo: .title))
            .foregroundStyle(.text)
    }
    
    func regular() -> some View {
        self.font(Font.custom("HostGrotesk-Regular", size: 18, relativeTo: .body))
            .foregroundStyle(.text)
    }
    
    func caption() -> some View {
        self.font(Font.custom("HostGrotesk-Light", size: 16, relativeTo: .caption))
            .foregroundStyle(.gray)
    }
}
