//
//  APIService.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI

struct APIService {
    // Process a request
    func fetchData<T: Decodable>(urlString: String, completion: @Sendable @escaping (T?, ErrorModel?) -> ())
    {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Failed to get data: ", err)
                return
            }
            
            DispatchQueue.main.async {
                if let error = self.isErrorOccurred(response: res, data: data) {
                    completion(nil, error)
                }
                
                if let modeledData: T = self.onSuccess(data: data) {
                    completion(modeledData, nil)
                }
            }
        }.resume()
    }
    
    // Find any error occurred on sending a request
    // Return nil if there is no error
    func isErrorOccurred(response: URLResponse?, data: Data?) -> ErrorModel? {
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode != 200 {
                // Error occurred
                let error = self.onError(httpResponse: httpResponse, data: data)
                return error
            }
        }
        
        return nil
    }
    
    // If the data returned is an error message,
    // parse the error object and return an ErrorModel object/nil
    func onError(httpResponse: HTTPURLResponse, data: Data?) -> ErrorModel? {
        print("Status code: \(httpResponse.statusCode)")
        
        let error: ErrorModel?
        guard let data = data else {return nil}
        
        do {
            let decoder = JSONDecoder()
            error = try decoder.decode(ErrorModel.self, from: data)
            print("Error code: \(error?.code ?? "")")
            print("Error message: \(error?.message ?? "")")
            return error
        } catch let err {
            print("Failed to serialize error json: ", err)
        }
        
        return nil
    }
    
    // If the data contained valid, parsable data
    // then parse JSON data and return data of specified type
    func onSuccess<T: Decodable>(data: Data?) -> T? {
        guard let data = data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let modeledData = try decoder.decode(T.self, from: data)
            return modeledData
        } catch let error {
            print("Failed to serialize json: ", error)
        }
        
        return nil
    }
}
