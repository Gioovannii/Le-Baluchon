//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/25.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var textOutput: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func translationTap(_ sender: UIButton) {
        
        TranslationService().getCurrency(textInput: "bonjour") { result in
            switch result {
            case .success(let data):
                print("data controller = \(data)")
            
            case .failure(let error):
                print(error)
            }
        }
    }
}
