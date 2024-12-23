//
//  ConversionDetailsModel.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

// GET: /client/convertdetails
// Params:
//  apiKey
//  from (required; 3-digit lowercased code)
//  amount (required; 100,23 for example)
//  date (required; YYYY-MM-DD)
//  currencies (optional; comma-separated list of 3-digit ISO codes)
struct ConversionDetailsModel: Decodable {
    let base: String
    let date: String
    let rates: [RateItem]
}

// Example:
// {
//    "symbol": "USD",
//    "currency": "United States Dollar",
//    "value": 1.000000
// }
struct RateItem: Decodable {
    let symbol: String
    let currency: String
    let value: Double
}
