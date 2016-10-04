//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-09-29.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(WEATHER_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? [String: Any] {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [[String: Any]] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? [String: Any] {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentTemp = String(format: "%.1f", currentTemperature)
                    }
                }
                
                if let date = dict["dt"] as? String {
                    self._date = date
                }
            }
            completed()
        }
    }

}
