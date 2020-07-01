//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/25.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UITextViewDelegate {
    // MARK: - Outlet
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var textOutputLabel: UILabel!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Text Field

    func textViewDidBeginEditing(_ textView: UITextView) {
        textInput.text = ""
    }
    
    // MARK: - Action
    @IBAction func translationTap(_ sender: UIButton) {
        
        let formattedString = textInput.text.replacingOccurrences(of: " ", with: "%20")
        
        textInput.resignFirstResponder()
        TranslationService().getCurrency(textInput: formattedString ) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(self.textInput.text!)
                    print("data controller = \(data)")
                    self.textOutputLabel.text = data
                }
                
            case .failure(let error):
                self.presentAlert(title: "Error", message: "No translation")
                print(error)
            }
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

