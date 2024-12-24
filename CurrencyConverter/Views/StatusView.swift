//
//  StatusView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/23/24.
//

import SwiftUI
import UIKit

struct StatusView: View {
    
    var statusIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @State var status: String! = ""
    @State var statusDescription: String! = ""
    @State var statusImage: String! = ""
    
    func getAPIStatus() {
         let url = Routes.checkOnlineUrl
        
         statusIndicator.startAnimating()
         
         APIService.fetchData(urlString: url) {
             (response: StatusModel?, error: ErrorModel?) in
             
             if let error = error {
                 self.status = "API is offline: \(error.code)"
                 self.statusDescription = error.message
             }
             
             if response!.result {
                 self.status = "API is online"
                 self.statusImage = "tick-circle"
             } else {
                 self.statusImage = "cross-circle"
             }
             
             self.statusIndicator.dismissLoader()
         }
     }
    
    var body: some View {
        ZStack {
            // Background color
            Color.pastelGreen.ignoresSafeArea()
            
            // Content
            VStack {
                // Title
                Text(status).title() 
                
                Text(statusDescription).regular()
                
                Image(statusImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 28)
                    .foregroundColor(.text)
            }
        }
        .onAppear() {
            getAPIStatus()
        }
    }
}
