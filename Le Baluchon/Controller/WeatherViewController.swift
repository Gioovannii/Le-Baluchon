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
  
//    private var weatherService = WeatherService()
    private var httpClient: HTTPClient = HTTPClient()
    
    
    
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
        
//         guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group?id=5128581%2C2968815&appid=17121490b9e3ea8f4d54dc0b563f9fb2&units=metric") else { return }
        
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group?") else { return }
        
        //                      ☣️ ajout de 52 apres le %2 de id  ici |
        httpClient.request(baseURL: url, parameters: [("id", "5128581%2C2968815"), ("appid", "17121490b9e3ea8f4d54dc0b563f9fb2"), ("units", "metric")]) { (result: Result<WeatherJSON, NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                     
                    print(data)
                }
                
            case .failure(let error):
                print(error)
                self.presentAlert(title: error.description, message: "")
            }
        }

       
        
        
//
//        WeatherService().getWeatherData() { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.update(weather: data)
//                    print("WeatherData Loaded")
//                    print(data)
//                }
//            case .failure(let error):
//                print(error)
//                self.presentAlert(title: "Heyyy", message: "Your request has gone wrong")
//            }
//       }
    }
    
    private func update(weather: WeatherData) {
        
        cityLabel[0].text = weather.cityNameParis
        temperatureLabel[0].text = weather.temperatureStringParis
        conditionImageView[0].image = UIImage(imageLiteralResourceName: weather.conditionNameParis)
        
        
        cityLabel[1].text = weather.cityName
        temperatureLabel[1].text = weather.temperatureString
        conditionImageView[1].image = UIImage(imageLiteralResourceName: weather.conditionName)
    }
}


