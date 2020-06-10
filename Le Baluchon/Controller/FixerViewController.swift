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
                    
                    guard let amountString = self.amountTextField.text else { return }
                    guard let DoubleString = Int(amountString) else { return }
                    self.amount = Double(DoubleString)
                    guard let result = self.updateResult(self.amount, self.rate) else { return }
                    self.amountTextField.text = ""
                    self.answerLabel.text = "\(self.amount) EUR = \(String(describing: result)) USD"
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func convertResponseToDouble() -> Double {
        guard let amountString = amountTextField.text else { return 0 }
        guard let DoubleString = Int(amountString) else { return 0 }
        print(Double(DoubleString))
        let amount = Double(DoubleString)
        return amount
    }
    func updateResult(_ amount: Double, _ rate: Double) -> Double? {
       let amountConvert =  convertResponseToDouble()
        answer = rate * amountConvert
        print("\(amount) EUR = \(answer) USD")
        return answer
    }
}
