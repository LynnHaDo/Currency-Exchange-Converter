//
//  String.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/25/24.
//

import SwiftUI

extension String {
    var isNumber: Bool {
        return Double(self) != nil 
    }
}
