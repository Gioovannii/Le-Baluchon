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
    @IBOutlet weak var conditionNewYorkImageView: UIImageView!
    @IBOutlet weak var temperatureNewYorkLabel: UILabel!
    @IBOutlet weak var newYorkLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    private var weatherService = WeatherService()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherService().getWeatherData() { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.temperatureNewYorkLabel.text = data.temperatureString
                    self.conditionNewYorkImageView.image = UIImage(imageLiteralResourceName: data.conditionName)
                    self.newYorkLabel.text = data.cityName
                    
                    self.temperatureLabel.text = data.temperatureString
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
        
//        searchTextField.delegate = self
    }

    @IBAction func locationPressed(_ sender: UIButton) {
        cityLabel.text = "Loading..."
        locationManager.requestLocation()
    }
    @IBAction func parisPressed(_ sender: UIButton) {
        // Update Paris location
    }
}

////MARK: - UITextFieldDelegate
//extension WeatherViewController: UITextFieldDelegate {
//
//    @IBAction func searchedPressed(_ sender: UIButton) { searchTextField.endEditing(true) }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchTextField.endEditing(true)
//        guard let text = searchTextField.text else { return true }
//        print(text)
//        return true
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        } else {
//            textField.placeholder = "Type Something"
//            return false
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let city = searchTextField.text { cityLabel.text = city }
//        searchTextField.text = ""
//    }
//}

//MARK: - LocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    // Get location by giving to the model then fetch via network Call
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last  {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("latitude = \(lat), longitude = \(lon)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
