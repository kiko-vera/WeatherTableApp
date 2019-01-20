//
//  ViewController.swift
//  WeatherTableApp
//
//  Created by Christopher Vera on 1/19/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "651327cbe40299e860a9aad332ef57a0"
    
    //Instance Variables
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    //Interface Builder Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Location Manager Set-up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Setting up the table view
        forecastTableView.separatorStyle = .none
        forecastTableView.rowHeight = 65.0
        
        //Setting up the search bar
        searchBar.placeholder = "Search cities"
        
    }
    
    //MARK: Networking Set-up through Alamofire
    func getWeatherData(URL: String, parameters: [String:String]) {
        Alamofire.request(URL, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data.")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("There's an error. Result: \(String(describing: response.result.error))")
                self.cityNameLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK: Parse Alamofire JSON response using SwiftyJSON
    func updateWeatherData(json: JSON) {
        if let currentTemperature = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(currentTemperature - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.conditionDescription = json["weather"][0]["description"].stringValue
            weatherDataModel.condition = json["weather"]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
        } else {
            cityNameLabel.text = "Weather unavailable."
        }
    }

    
    //MARK: UI Update with info from Weather API
    func updateUIWithWeatherData() {
        cityNameLabel.text = weatherDataModel.city
        currentTemperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIconImageView.image = UIImage(named: weatherDataModel.weatherIconName)
        conditionsLabel.text = weatherDataModel.conditionDescription
    }
    
    //MARK: Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params: [String : String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(URL: WEATHER_URL, parameters: params)
        }
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityNameLabel.text = "Location unavailable."
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: UITableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherForecastTableViewCell
        
        cell.dayOfTheWeekLabel.text = "monday"
        cell.lowTemperatureForecastLabel.text = "\(17)"
        cell.highTemperatureForecastLabel.text = "\(38)"
        cell.weatherForecastIcon.image = UIImage(named: "sunny")
        
        return cell
    }
    
    //MARK: UITableView Delegate Methods
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "5-Day Forecast"
    }
    
}
