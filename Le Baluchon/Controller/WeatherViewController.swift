//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/23.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var newYorkLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var weatherService = WeatherService()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherService().getWeatherData(cityName: "New%20York") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                }
            case .failure(let error):
                print(error)
            }
        }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation() to constant monitor the location
        locationManager.requestLocation()
        
        searchTextField.delegate = self
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        cityLabel.text = "Loading..."
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchedPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        guard let text = searchTextField.text else { return true }
        print(text)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            //            weatherService.fetchWeather(cityName: city)
            cityLabel.text = city
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherServiceDelegate
extension WeatherViewController {
    
    func didUpdateWeather(_ weatherManager: WeatherService, weather: WeatherData) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(imageLiteralResourceName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
}

//MARK: - LocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    // Get location by giving to the model then fetch via network Call
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last  {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("\(lat), \(lon)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
