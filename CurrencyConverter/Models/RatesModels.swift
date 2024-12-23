//
//  RatesModels.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

// GET: /client/latestdetails
// Params:
//  apiKey
//  base_currency (optional; lowercase 3-digit string)
//  currencies (optional; comma-separated currencies we want to convert to)
struct LatestDetailsModel: Decodable {
    let base: String
    let date: String
    let rates: [RateItem]
}

// GET: /client/historydetails
// Params:
//  apiKey
//  base_currency (optional; lowercase 3-digit string)
//  date (required; YYYY-MM-DD string)
//  currencies (optional; comma-separated currencies we want to convert to)
struct HistoryDetailsModel: Decodable {
    let base: String
    let date: String
    let rates: [RateItem]
}
