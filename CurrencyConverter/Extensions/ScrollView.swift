//
//  ScrollView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/24/24.
//

import SwiftUI

extension ScrollView {
    func list() -> some View {
        self.frame(maxHeight: 400)
            .contentMargins(.horizontal, 30)
            .scrollBounceBehavior(.always)
            .scrollTargetBehavior(.viewAligned) // paging behaviour
            .font(Font.custom("HostGrotesk-Regular", size: 18, relativeTo: .body))
    }
}
