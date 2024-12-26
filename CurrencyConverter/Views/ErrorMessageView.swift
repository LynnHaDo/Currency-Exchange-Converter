//
//  ErrorMessageView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/25/24.
//

import SwiftUI

struct ErrorMessageView: View {
    let errorObj: ErrorModel?
    
    var body: some View {
        VStack {
            if (errorObj != nil)
            {
                Text("An error occurred: \(errorObj!.code)").regular()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                Text(errorObj!.message).caption().fixedSize(horizontal: false, vertical: true)
            }
            else {
                Text("An error occurred").regular().fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                Text("Please try again later.").caption().fixedSize(horizontal: false, vertical: true)
            }
        }
        .multilineTextAlignment(.center)
        .padding(20)
    }
}
