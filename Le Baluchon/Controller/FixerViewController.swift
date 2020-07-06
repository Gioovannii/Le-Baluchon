//
//  FixerViewController.swift
//  Le Baluchon
//
//  Created by mac on 2020/6/4.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

final class FixerViewController: UIViewController {
    /// Stack overflow link many dev enconter the same problem
    //https://stackoverflow.com/questions/32647090/cant-find-keyplane-that-supports-type-4-for-keyboard-iphone-portrait-numberpad/34126463
    
    // MARK: - Outlet
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    private let httpClient: HTTPClient = HTTPClient()
    
    // MARK: - Properties
    var amount: Double = 0.00
    var rate: Double = 0.00
    var answer : Double = 0.00
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(FixerViewController.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controller receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(FixerViewController.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Action
    /// Network call
    /// - Parameter sender: UI Button pressed
    @IBAction func convertPressed(_ sender: UIButton) {
        
        amountTextField.resignFirstResponder()
        
        //        let currency = "USD"
        guard let url = URL(string: "http://data.fixer.io/api/latest?") else { return }
        
        httpClient.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { [unowned self] (result: Result<FixerJSON, NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    guard let usd = data.rates["USD"] else { return }
                    self.rate = usd
                    print(self.rate)
                    
                    guard let result = self.updateResult(self.amount, self.rate) else { return }
                    
                    let resultStr = self.formatResult(number: result)
                    let format = self.formatResult(number: self.amount)
                    
                    self.answerLabel.text = "\(format) EUR = \(resultStr) USD"
                    self.amountTextField.text = ""
                    
                    
                }
            case .failure(let error):
                print(error.description)
                
            }
        }
    }
}



// MARK: - @objc method to show and hide
extension FixerViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard's height
        self.view.frame.origin.y = 180 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
}

// MARK: - convert and update
extension FixerViewController {
    private func convertResponseToDouble() -> Double {
        guard let amountString = amountTextField.text else { return 0 }
        print("amount string", amountString)
        
        guard let amount = Double(amountString) else {
            presentAlert(title: "Error", message: "This is not a correct decimal number")
            return 0.0
        }
        print(amount)
        return amount
    }
    
    /// Once checked amount we update answer
    private func updateResult(_ amount: Double, _ rate: Double) -> Double? {
        let amountUser =  convertResponseToDouble()
        self.amount = amountUser
        answer = rate * amountUser
        print("\(amountUser) EUR = \(answer) USD")
        return answer
    }
 
    /// Format to 3 digit
    private func formatResult(number: Double) -> String {
        let formater = NumberFormatter()
        formater.maximumFractionDigits = 3
        
        guard let resultFormated = formater.string(from: NSNumber(value: number)) else { return String()}
        return resultFormated
    }
}

extension UIViewController {
    /// Alert for handle errors
       func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           present(alert, animated: true)
       }
}

