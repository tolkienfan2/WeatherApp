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
    var _weatherImg: String!
    var _currentTemp: String!
    var _hiTemp: String!
    var _loTemp: String!
    
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
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherImg: String {
        if _weatherImg == nil {
            _weatherImg = ""
        }
        return _weatherImg
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
   
    var hiTemp: String {
        if _hiTemp == nil {
            _hiTemp = ""
        }
        return _hiTemp
    }

    var loTemp: String {
        if _loTemp == nil {
            _loTemp = ""
        }
        return _loTemp
    }
  
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        print(WEATHER_URL)
        Alamofire.request(WEATHER_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? [String: Any] {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [[String: Any]] {
                    
                    if let img = weather[0]["main"] as? String {
                        self._weatherImg = img.capitalized
                    }
                    
                    if let desc = weather[0]["description"] as? String {
                        self._weatherType = desc.capitalized
                    }
                }
                
                if let main = dict["main"] as? [String: Any] {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentTemp = String(format: "%.1f", currentTemperature)
                    }
                    
                    if let hiTemp = main["temp_max"] as? Double {
                        self._hiTemp = String(format: "%.1f", hiTemp)
                    }
                    
                    if let loTemp = main["temp_min"] as? Double {
                        self._loTemp = String(format: "%.1f", loTemp)
                    }
                    
                }
                
                if (dict["dt"] as? Double) != nil {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .full
                    dateFormatter.timeStyle = .none
                    let currentDate = dateFormatter.string(from: Date())
                    dateFormatter.dateFormat = "EEEE"
                    self._date = "\(currentDate)"
                }
            }
            completed()
        }
    }

}
