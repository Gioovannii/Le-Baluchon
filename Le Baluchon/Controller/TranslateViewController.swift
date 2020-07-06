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
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var textOutputLabel: UILabel!
    @IBOutlet weak var loadingUserButton: UIButton!
    @IBOutlet weak var englishOutletButton: UIButton!
    @IBOutlet weak var mandarinOutletButton: UIButton!
    
    
    var target = "en"
    let customBlue = UIColor(red: 0.614, green: 0.697, blue: 0.984, alpha: 1)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Text Field
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        loadingUserButton.setTitle("Get translation", for: .normal)
        inputTextView.text = ""
    }
    
    @IBAction func englishButtonTap(_ sender: Any) {
        englishOutletButton.attributedTitle(for: .disabled)
        englishOutletButton.backgroundColor = customBlue
        mandarinOutletButton.backgroundColor = .groupTableViewBackground
        target = "en"
    }
    @IBAction func mandarinButtonTap(_ sender: Any) {
        mandarinOutletButton.backgroundColor = customBlue
        englishOutletButton.backgroundColor = .groupTableViewBackground
        target = "zh-TW"
    }
    
    // MARK: - Action
    @IBAction func translationTap(_ sender: UIButton) {
        loadingUserButton.setTitle("Loading", for: .normal)
        
        inputTextView.resignFirstResponder()
        TranslationService().getCurrency(textInput: inputTextView.text, target: target) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(self.inputTextView.text!)
                    print("data controller = \(data)")
                    self.loadingUserButton.setTitle("Here you're translation", for: .normal)
                    self.textOutputLabel.text = data
                    
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.textOutputLabel.text = "Unavailable"
                    self.presentAlert(title: "\(error.description)", message: "")
                    print(error)
                }
            }
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

