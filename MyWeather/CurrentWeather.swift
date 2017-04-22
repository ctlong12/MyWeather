//
//  CurrentWeather.swift
//  MyWeather
//
//  Created by Chandler on 4/15/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    var _humidity: Double!
    var _windSpeed: Double!
    var _sunset: String!
    
    
    //Setting conditions if nothing has been pulled form API
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var sunset: String {
        if _sunset == nil {
            _sunset = ""
        }
        return _sunset
    }
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var humidity: Double {
        if _humidity == nil {
            _humidity = 0.0
        }
        return _humidity
    }
    
    var windSpeed: Double {
        if _windSpeed == nil {
            _windSpeed = 0.0
        }
        return _windSpeed
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    

    //Alamofire download
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            if let dict  = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print("City: ", self._cityName)
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print("Weather: ", self._weatherType)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTempurature = main["temp"] as? Double {
                        let convertKelvinToFaren = (currentTempurature * (9/5) - 459.67)
                        let faren  = Double(round(10 * convertKelvinToFaren/10))
                        self._currentTemp = faren
                        print("Tempurature: ", self._currentTemp)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let humidity = main["humidity"] as? Double {
                        self._humidity = humidity
                        print("Humidity: ", self.humidity)
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let windSpeed = wind["speed"] as? Double {
                        self._windSpeed = round(windSpeed)
                        print("Wind Speed: ", self._windSpeed)
                    }
                }
                
                if let sunset = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let sunsetTime = sunset["sunset"] as? Int {
                        let time = NSDate(timeIntervalSince1970: TimeInterval(sunsetTime))
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "h:mm a"
                        
                        let timeString = dayTimePeriodFormatter.string(from: time as Date)
                        self._sunset = timeString
                        print("Sunset: ", timeString)
                    }
                }
            }
            completed()
        }
    }
}







