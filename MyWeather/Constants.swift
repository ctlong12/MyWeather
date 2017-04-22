//
//  Constants.swift
//  MyWeather
//
//  Created by Chandler on 4/15/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//


import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "dda85d48fed364ba0540b2825d114021"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=dda85d48fed364ba0540b2825d114021"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=dda85d48fed364ba0540b2825d114021"


typealias DownloadComplete = () -> ()
