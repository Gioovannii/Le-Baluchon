//
//  File.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/7/23.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Alert for handle errors
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
