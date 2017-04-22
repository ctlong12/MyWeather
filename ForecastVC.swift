//
//  ForecastVC.swift
//  MyWeather
//
//  Created by Chandler on 4/16/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit
import Alamofire

class ForecastVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let customSlideToHome = CustomSlideToHome()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadForecastData {
            self.tableView.reloadData()
        }
        
    }
    
    //Converting forecast data into single dictionry items
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)
        
        Alamofire.request(forecastURL!).responseJSON { response in
            
            let result  = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list  = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        
                        let forcast = Forecast(weatherDict: obj)
                        self.forecasts.append(forcast)
                        print(obj)
                    }
                }
            }
            completed()
        }
    }
    
    //Table View Functions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        destination.transitioningDelegate = customSlideToHome
    }
    
    @IBAction func backToHomePressed(_ sender: Any) {
        performSegue(withIdentifier: "backToHome", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
}
