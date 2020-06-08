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
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionNewYorkImageView: UIImageView!
    @IBOutlet weak var temperatureNewYorkLabel: UILabel!
    @IBOutlet weak var newYorkLabel: UILabel!
    
    private var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WeatherService().getWeatherData() { result in
                   switch result {
                   case .success(let data):
                       DispatchQueue.main.async {
                           self.update(weather: data)
                           print(data)
                       }
                   case .failure(let error):
                       print(error)
                       self.presentAlert()
                   }
               }
    }
    @IBAction func refreshPressed(_ sender: UIBarButtonItem) {
        
        print("touch")
    }
    
    
    private func update(weather: WeatherData) {
        cityLabel.text = weather.cityNameParis
        temperatureLabel.text = weather.temperatureStringParis
        conditionImageView.image = UIImage(imageLiteralResourceName: weather.conditionNameParis)
        
        newYorkLabel.text = weather.cityName
        temperatureNewYorkLabel.text = weather.temperatureString
        conditionNewYorkImageView.image = UIImage(imageLiteralResourceName: weather.conditionName)
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Heyyy", message: "Your request has gone wrong", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
