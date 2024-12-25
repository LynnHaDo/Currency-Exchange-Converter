//
//  StringFormatters.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/25/24.
//

import SwiftUI

struct StringFormatters {
    
    // Convert a date to YYYY-MM-DD format
    static func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // Custom number formatter
    static let customNumberformatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.zeroSymbol = ""
        return formatter 
    }()
    
    static func doubleToString(number: Double) -> String {
        StringFormatters.customNumberformatter.string(for: number) ?? ""
    }
    
    // Check if the number is valid
    static func isStringValidNumber(numString: String) -> Bool {
        return numString.isNumber
    }
}
