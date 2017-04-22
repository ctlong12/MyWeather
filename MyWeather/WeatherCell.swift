//
//  WeatherCell.swift
//  MyWeather
//
//  Created by Chandler on 4/18/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!

    
    //Configuring the forecast Table View
    func configureCell(forecast: Forecast) {
        lowTempLabel.text = "\(forecast.lowTemp)"
        highTempLabel.text = "\(forecast.highTemp)"
        weatherTypeLabel.text = forecast.weatherType
        dayOfWeekLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }
    
}
