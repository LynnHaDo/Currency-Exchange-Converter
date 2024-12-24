//
//  ActivityIndicatorView.swift
//  CurrencyConverter
//
//  Created by Do Linh on 12/24/24.
//

import UIKit

extension UIActivityIndicatorView {
    func dismissLoader() {
        self.stopAnimating()
        self.isUserInteractionEnabled = true
    }
}
