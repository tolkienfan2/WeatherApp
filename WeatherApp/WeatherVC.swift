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
import GoogleMobileAds

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hiTempLabel: UILabel!
    @IBOutlet weak var loTempLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var geocoder: CLGeocoder!
    
    var currentWeather: CurrentWeather!
    var forecast: WeatherForecast!
    var forecasts = [WeatherForecast]()
    
    @IBOutlet weak var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        geocoder = CLGeocoder()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        bannerView?.delegate = self
        loadAd()
    }
    
    func loadWeatherData() {
        
        print("LOCATION: \(LOCATION)")
        
        currentWeather = CurrentWeather()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainView()
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func updateMainView() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)?.appending("ºC")
        hiTempLabel.text = String(currentWeather.hiTemp)?.appending("º")
        loTempLabel.text = String(currentWeather.loTemp)?.appending("º")
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImg.image = UIImage(named: currentWeather.weatherImg)
        activityIndicator.stopAnimating()
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? [String: Any] {
                
                if let list = dict["list"] as? [[String: Any]] {
                    
                    var tempArray = [WeatherForecast]()
                    
                    for obj in list {
                        let forecast = WeatherForecast(weatherDict: obj)
                        tempArray.append(forecast)
                    }
                    tempArray.remove(at: 0)
                    self.forecasts = tempArray
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.last
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if error != nil {
                self.locationLabel.text = "Lat:" + String(format: "%.2f", lat) + ", Lon:" + String(format: "%.2f", lon)
            }
            else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                        self.locationLabel.text = placemark.locality
                }
                else {
                self.locationLabel.text = "Lat:" + String(format: "%.2f", lat) + ", Lon:" + String(format: "%.2f", lon)
                }
            }
        }
        Location.sharedInstance.latitude = lat
        Location.sharedInstance.longitude = lon
        loadWeatherData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.section]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func loadAd() {
        bannerView?.adUnitID = ADMOB_AD_UNIT_ID
        bannerView?.rootViewController = self
        bannerView?.adSize = kGADAdSizeSmartBannerPortrait
        bannerView?.load(GADRequest())
        self.view.addSubview(bannerView!)
    }

}

