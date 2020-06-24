//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/23.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet var conditionImageView: [UIImageView]!
    @IBOutlet var temperatureLabel: [UILabel]!
    @IBOutlet var cityLabel: [UILabel]!
  
    private var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkCall()
        presentAlert(title: "You're back here", message: "Here we go. We update your city weather")
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        networkCall()
        print("touch reload")
        presentAlert(title: "Reload", message: "Here we go reload done!")
    }
    
    func networkCall() {
        WeatherService().getWeatherData() { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.update(weather: data)
                    print("WeatherData Loaded")
                    print(data)
                }
            case .failure(let error):
                print(error)
                self.presentAlert(title: "Heyyy", message: "Your request has gone wrong")
            }
        }
    }
    
    private func update(weather: WeatherData) {
        
        cityLabel[0].text = weather.cityNameParis
        temperatureLabel[0].text = weather.temperatureStringParis
        conditionImageView[0].image = UIImage(imageLiteralResourceName: weather.conditionNameParis)
        
        
        cityLabel[1].text = weather.cityName
        temperatureLabel[1].text = weather.temperatureString
        conditionImageView[1].image = UIImage(imageLiteralResourceName: weather.conditionName)
    }
    
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Continue", style: .cancel))
        self.present(alertVC, animated: true)
    }
}
