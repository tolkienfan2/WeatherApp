//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-09-30.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import Foundation
import Alamofire

class WeatherForecast {
    
    var _date: String!
    var _weatherType: String!
    var _tempMin: Double!
    var _tempMax: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short           //adjust to show day only
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "\(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var tempMin: Double {
        if _tempMin == nil {
            _tempMin = 0
        }
        return _tempMin
    }
    
    var tempMax: Double {
        if _tempMax == nil {
            _tempMax = 0
        }
        return _tempMax
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        let forecastURL = URL(string: MAIN_URL + FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? [String: Any] {
                
                if let forecast = dict["list"] as? [[String: Any]] {
                    
                    if let date = forecast[0]["dt"] as? String {
                        self._date = date
                    }
                    
                    if let weather = forecast[0]["weather"] as? [[String: Any]] {
                        if let main = weather[0]["main"] as? String {
                            self._weatherType = main
                        }
                    }
                    
                    if let temperature = forecast[0]["main"] as? [String: Double] {
                        
                        let temp_max = temperature["temp_max"]
                            self._tempMax = temp_max
                        
                        let temp_min = temperature["temp_min"]
                            self._tempMin = temp_min
                    }
                }
            }
            print(self._weatherType)
            print(self.tempMax)
            completed()
        }
    }
    
}
