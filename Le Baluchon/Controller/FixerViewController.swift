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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        FixerService().getCurrency(devise: "USD") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func amountTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
