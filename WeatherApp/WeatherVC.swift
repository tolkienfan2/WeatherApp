//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-09-28.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: WeatherForecast!
    var forecasts = [WeatherForecast]()
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        startLocationManager()
        currentWeather = CurrentWeather()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainView()
            }
        }
    }
    
    func startLocationManager() {
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            currentLocation = locations.last
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }

    func updateMainView() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)?.appending("ºC")
        locationLabel.text = currentWeather.cityName
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? [String: Any] {
                if let list = dict["list"] as? [[String: Any]] {
                    for obj in list {
                        let forecast = WeatherForecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
}
