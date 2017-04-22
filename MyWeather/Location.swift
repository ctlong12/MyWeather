//
//  Location.swift
//  MyWeather
//
//  Created by Chandler on 4/22/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
