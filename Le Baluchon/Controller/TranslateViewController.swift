//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/25.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var textOutputLabel: UILabel!
    @IBOutlet weak var loadingUserButton: UIButton!
    @IBOutlet weak var englishOutletButton: UIButton!
    @IBOutlet weak var mandarinOutletButton: UIButton!
    @IBOutlet weak var frenchLabel: UILabel!
    @IBOutlet weak var getTranslationButton: UIButton!
    
    // MARK: - Properties
    
    private let translateService = TranslationService()
    private var target = "en"
    private let customBlue = UIColor(red: 0.614, green: 0.697, blue: 0.984, alpha: 1)
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        englishOutletButton.layer.cornerRadius = 10
        mandarinOutletButton.layer.cornerRadius = 10
        
        frenchLabel.layer.cornerRadius = 10
        frenchLabel.layer.masksToBounds = true
        getTranslationButton.layer.cornerRadius = 10
        inputTextView.layer.cornerRadius = 10
        
        textOutputLabel.layer.cornerRadius = 10
        textOutputLabel.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    
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
        guard let text = inputTextView.text else { return }
        
        inputTextView.resignFirstResponder()
        
        translateService.getTranslation(textInput: text, target: target) { [unowned self] result  in
            switch result {
            case .success(let text):
                DispatchQueue.main.async {
                    guard text.data.translations[0].detectedSourceLanguage == "fr" else {
                        self.presentAlert(title: "In French please", message: "")
                        self.loadingUserButton.setTitle("You missed it!", for: .normal)
                        self.textOutputLabel.text = "In french please"
                        return
                    }
                    print("Text Translated = \(text.data.translations[0].translatedText)")
                    self.loadingUserButton.setTitle("Here youre translation", for: .normal)
                    self.textOutputLabel.text = text.data.translations[0].translatedText
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentAlert(title: error.description, message: "")
                }
            }
        }
    }
}

extension TranslateViewController: UITextViewDelegate {
    // MARK: - Text Field
    
    internal func textViewDidBeginEditing(_ textView: UITextView) {
        loadingUserButton.setTitle("Get translation", for: .normal)
        inputTextView.text = ""
    }
}

