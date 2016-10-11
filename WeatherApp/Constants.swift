//
//  Constants.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-09-29.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import Foundation

private var _APIKEY = "6ce258e8689137132fcce079ac013e71"

let MAIN_URL = "http://api.openweathermap.org"

let latitude = Location.sharedInstance.latitude ?? 45.411171
let longitude = Location.sharedInstance.longitude ?? -75.69812

let LOCATION = "lat=\(latitude)&lon=\(longitude)"

let WEATHER = "/data/2.5/weather?"

let TODAYS_TEMPS = "/data/2.5/forecast?"

let FORECAST = "/data/2.5/forecast/daily?"

let PARAMETERS = "&units=metric" + "&APPID=\(_APIKEY)"

let WEATHER_URL = MAIN_URL + WEATHER + LOCATION + PARAMETERS

let TODAYS_TEMPS_URL = MAIN_URL + TODAYS_TEMPS + LOCATION + PARAMETERS

let FORECAST_URL = MAIN_URL + FORECAST + LOCATION + PARAMETERS

typealias DownloadComplete = () -> ()
