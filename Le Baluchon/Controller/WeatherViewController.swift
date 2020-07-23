//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/23.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet var conditionImageView: [UIImageView]!
    @IBOutlet var temperatureLabel: [UILabel]!
    @IBOutlet var cityLabel: [UILabel]!
    
    private var httpClient: HTTPClient = HTTPClient()
    private var weatherService = WeatherService()
    private var weathersData = [CityData]()
    
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
    
    private func networkCall() {
        weatherService.getWeatherData { [unowned self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.update(citiesData: data)
                }
            case .failure(let error):
                self.presentAlert(title: "error", message: error.description)
            }
        }
    }
    
    private func update(citiesData: [CityData]) {
        for i in 0...1 {
            cityLabel[i].text = citiesData[i].cityName
            temperatureLabel[i].text = citiesData[i].temperatureString
            conditionImageView[i].image = UIImage(imageLiteralResourceName: citiesData[i].getCondition(to: citiesData[i].conditionId))
        }
    }
}


