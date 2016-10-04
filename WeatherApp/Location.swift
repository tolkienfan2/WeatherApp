//
//  Location.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-10-03.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
