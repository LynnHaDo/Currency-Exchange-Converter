//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

// GET: /client/currencies
// Params: apiKey
struct CurrencyModel: Decodable {    
    let symbol: String
    let description: String
}
