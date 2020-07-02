//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/25.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController, UITextViewDelegate {
    // MARK: - Outlet
    @IBOutlet weak var textInput: UITextView!
    @IBOutlet weak var textOutputLabel: UILabel!
    @IBOutlet weak var loadingUserButton: UIButton!
    
    var target = "en"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Text Field

    func textViewDidBeginEditing(_ textView: UITextView) {
        loadingUserButton.setTitle("Get translation", for: .normal)
        textInput.text = ""
    }
    
    @IBAction func englishButtonTap(_ sender: Any) {
        presentAlert(title: "English Activated", message: "")
        target = "en"
    }
    @IBAction func mandarinButtonTap(_ sender: Any) {
         presentAlert(title: "Mandarin Activated", message: "")
        target = "zh-TW"
    }
    
    
    // MARK: - Action
    @IBAction func translationTap(_ sender: UIButton) {
        loadingUserButton.setTitle("Loading", for: .normal)
        
        let formatSpaces = textInput.text.replacingOccurrences(of: " ", with: "%20")

        textInput.resignFirstResponder()
        TranslationService().getCurrency(textInput: formatSpaces, target: target) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(self.textInput.text!)
                    print("data controller = \(data)")
                    self.loadingUserButton.setTitle("Here you're translation", for: .normal)
                    self.textOutputLabel.text = data

                }
                
            case .failure(let error):
                self.presentAlert(title: "\(error)", message: "No translation")
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

