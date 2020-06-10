//
//  FixerViewController.swift
//  Le Baluchon
//
//  Created by mac on 2020/6/4.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

class FixerViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    var amount: Double = 0.00
    var amountString: String {
        return String(format: "%.0f", amount)
    }
    
    var rate: Double = 0.00
    var answer : Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        amountTextField.resignFirstResponder()
        FixerService().getCurrency(devise: "USD") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    
                    self.rate = data
                    print(self.rate)

                    guard let result = self.updateResult(self.amount, self.rate) else { return }
                    var resultString: String {
                        return String(format: "%.3f", result)
                    }
                    
                    self.answerLabel.text = "\(self.amountString) EUR = \(resultString) USD"
                    self.amountTextField.text = ""
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func convertResponseToDouble() -> Double {
        guard let amountString = amountTextField.text else { return 0 }
        guard let DoubleString = Int(amountString) else { return 0 }
        print(Double(DoubleString))
        let amount = Double(DoubleString)
        return amount
    }
    
    private func updateResult(_ amount: Double, _ rate: Double) -> Double? {
        let amountUser =  convertResponseToDouble()
        self.amount = amountUser
        answer = rate * amountUser
        print("\(amountUser) EUR = \(answer) USD")
        return answer
    }
}
