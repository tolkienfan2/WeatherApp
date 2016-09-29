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

let WEATHER_URL = "/data/2.5/weather?id=6094817" + "&units=metric" + "&APPID=\(_APIKEY)"

let FORECAST_URL = "/data/2.5/forecast?id=6094817" + "&units=metric" + "&APPID=\(_APIKEY)"

let ICON_URL = "/img/w/"

typealias DownloadComplete = () -> ()
