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
    
    // MARK: - Properties
    private var httpClient: HTTPClient = HTTPClient()
    var target = "en"
    let customBlue = UIColor(red: 0.614, green: 0.697, blue: 0.984, alpha: 1)
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        guard let text = inputTextView.text else { return }
        
        inputTextView.resignFirstResponder()
        
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return }
        httpClient.request(baseURL: url, parameters: [("key", "AIzaSyA7U25Y2ynHepATFgDdEBAHjSvaVIK9WTQ"), ("q", text), ("target", target), ("model", "base")]) { (result: Result<TranslateJSON, NetworkError>) in
            switch result {
            case .success(let text):
                DispatchQueue.main.async {
                guard text.data.translations[0].detectedSourceLanguage == "fr" else {
                    self.presentAlert(title: "In French please", message: "")
                    self.loadingUserButton.setTitle("You missed it!", for: .normal)
                    self.textOutputLabel.text = "In french please"
                    return
                }
                
                print(text)
                print(text.data.translations[0].translatedText)
                    self.loadingUserButton.setTitle("Here youre translation", for: .normal)
                    self.textOutputLabel.text = text.data.translations[0].translatedText
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    self.presentAlert(title: error.description, message: "")
                }
            }
        }
    }
}

extension TranslateViewController: UITextViewDelegate {
    // MARK: - Text Field
       
       func textViewDidBeginEditing(_ textView: UITextView) {
           loadingUserButton.setTitle("Get translation", for: .normal)
           inputTextView.text = ""
       }
}
