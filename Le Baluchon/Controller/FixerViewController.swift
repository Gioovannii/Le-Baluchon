//
//  FixerViewController.swift
//  Le Baluchon
//
//  Created by mac on 2020/6/4.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

final class FixerViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    // MARK: - Properties
    private let fixer = FixerService()
    
    private var amount: Double = 0.00
    private var rate: Double = 0.00
    private var answer : Double = 0.00
    
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
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        
        amountTextField.resignFirstResponder()
                
        fixer.getCurrency(currency: "USD") { [unowned self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let usd = data.rates["USD"] else { return }
                    self.rate = usd
                    
                    guard let result = self.updateResult(self.amount, self.rate) else { return }
                    
                    self.answerLabel.text = "\(self.amount.stringDigitFormat) EUR = \(result.stringDigitFormat) USD"
                    self.amountTextField.text = ""
                }
                
            case .failure(let error):
                self.presentAlert(title: "Error", message: error.description)
            }
        }
    }
}

// MARK: - @objc method to show and hide
extension FixerViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        // if keyboard size is not available for some reason, dont do anything
        
        
        // move the root view up by the distance of keyboard's height
        self.view.frame.origin.y = 180 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) { self.view.frame.origin.y = 0 }
    // move back the root view origin to zero
}

// MARK: - convert and update
extension FixerViewController {
    private func convertResponseToDouble() -> Double {
        guard let amountString = amountTextField.text else { return 0 }
                
        guard let amount = Double(amountString) else {
            presentAlert(title: "Error", message: "This is not a correct decimal number")
            return 0.0
        }
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
}


// Fichier à part
extension UIViewController {
    /// Alert for handle errors
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

