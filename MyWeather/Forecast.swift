//
//  Forecast.swift
//  MyWeather
//
//  Created by Chandler on 4/16/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!

    //Setting conditions if nothing has been pulled form API
    var date: String{
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
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    
    //Setting API values to the appropriate varibales 
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject> {
            if let min = temp["min"] as? Double {
                let convertKelvinToFaren = (min * (9/5) - 459.67)
                let faren  = Double(round(10 * convertKelvinToFaren/10))
                self._lowTemp = "\(faren)"
                print(self._lowTemp)
            }
            if let max = temp["max"] as? Double {
                let convertKelvinToFaren = (max * (9/5) - 459.67)
                let faren  = Double(round(10 * convertKelvinToFaren/10))
                self._highTemp = "\(faren)"
                print(self._highTemp)
            }
            
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
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

