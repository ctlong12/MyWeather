//
//  CurrentWeatherVC.swift
//  MyWeather
//
//  Created by Chandler on 4/14/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentWeatherVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var scrollToForcast: UIScrollView!
    
    let customSlideToForcast = CustomSlideToForcast()
    var currentWeather = CurrentWeather()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        locationAuthStatus()
        
    }
    
    //Asking permmission for users location, then finding it 
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.updateMainUI()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    
    //Updating GUI
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        tempLabel.text = "\(Int(currentWeather.currentTemp))°F"
        humidityLabel.text = "\(currentWeather.humidity)%"
        windSpeedLabel.text = "\(currentWeather.windSpeed) mph"
        sunsetTimeLabel.text = currentWeather.sunset
        weatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        weatherIcon.image = UIImage(named: currentWeather.weatherType)
        weatherIcon.contentMode = .scaleAspectFit
    }
    
    
    
    //Seque Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        destination.transitioningDelegate = customSlideToForcast
    }
    
    @IBAction func swipeToForcast(_ sender: Any) {
        
        performSegue(withIdentifier: "forcast", sender: nil)
        
    }
    
}
