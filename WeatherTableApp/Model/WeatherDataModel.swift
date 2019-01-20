//
//  WeatherDataModel.swift
//  WeatherTableApp
//
//  Created by Christopher Vera on 1/19/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    //Declare your model variables here
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    var conditionDescription: String = ""
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "heavy_rain"
            
        case 301...500 :
            return "rain"
            
        case 501...600 :
            return "light_showers"
            
        case 601...700 :
            return "snowflake"
            
        case 701...771 :
            return "windy"
            
        case 772...799 :
            return "thunder_storm"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "party_cloudy"
            
        case 900...903, 905...1000  :
            return "heavy_rain"
            
        case 903 :
            return "snowing"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
}
