//
//  Settings.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/22/24.
//

enum Secrets {
    static let ratesExchangeApiKey = "364c1f12-92e3-4c59-808e-2bd3dc886985"
}

struct Routes {
    // Documentation: https://ratesexchange.eu/Docs
    static let baseUrl = "https://api.ratesexchange.eu/client"
    
    // Check API Status
    static let checkOnlineUrl = "\(baseUrl)/checkapi"
    // API Key param
    static let apiKeyParam = "?apiKey=\(Secrets.ratesExchangeApiKey)"
    // Get the latest rates
    static let latestDetailsUrl = "\(baseUrl)/latestdetails\(apiKeyParam)"
    // Get the converted amount
    static let convertDetailsUrl = "\(baseUrl)/convertdetails\(apiKeyParam)"
    // Get the available currencies
    static let currenciesUrl = "\(baseUrl)/currencies\(apiKeyParam)"
}
