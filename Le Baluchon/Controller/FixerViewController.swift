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
        FixerService().getCurrency(currency: "USD") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    self.rate = data
                    print(self.rate)
                    
                    guard let result = self.updateResult(self.amount, self.rate) else { return }
                    var resultString: String {
                        return String(format: "%.3f", result)
                    }
                    
                    self.answerLabel.text = "\(self.amount) EUR = \(resultString) USD"
                    self.amountTextField.text = ""
                    
                }
            case .failure(let error):
                print(error)
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
            return 0.0 }
        print(amount)
        return amount
    }
    
    // Once checked amount we update answer
    private func updateResult(_ amount: Double, _ rate: Double) -> Double? {
        let amountUser =  convertResponseToDouble()
        self.amount = amountUser
        answer = rate * amountUser
        print("\(amountUser) EUR = \(answer) USD")
        return answer
    }
    
    // Alert for handle errors
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .cancel))
        present(alert, animated: true)
    }
}

