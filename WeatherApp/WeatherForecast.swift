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
    var _tempMin: String!
    var _tempMax: String!
    
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
    
    var tempMin: String {
        if _tempMin == nil {
            _tempMin = ""
        }
        return _tempMin
    }
    
    var tempMax: String {
        if _tempMax == nil {
            _tempMax = ""
        }
        return _tempMax
    }
    
    init(weatherDict: [String: Any]) {
        
        if let date = weatherDict["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE"
            self._date = unixDate.dayOfTheWeek()
        }
                
        if let weather = weatherDict["weather"] as? [[String: Any]] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                }
            }
                    
        if let temperature = weatherDict["temp"] as? [String: Any] {
                        
            if let temp_max = temperature["max"] as? Double {
                self._tempMax = String(format: "%.1f", temp_max)
            }
            
            if let temp_min = temperature["min"] as? Double {
                self._tempMin = String(format: "%.1f", temp_min)
            }
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
