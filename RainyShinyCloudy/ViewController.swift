//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Hermann Dorio on 08/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var weatherState: UILabel!
    @IBOutlet weak var imageofweather: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var degreetext: UILabel!
    @IBOutlet weak var todaydate: UILabel!
    @IBOutlet weak var mytabelview: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    var Forecasts = [Forecast]()
    var currentWeather:CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytabelview.delegate = self
        self.mytabelview.dataSource = self

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
    }
    
    func locationAuthStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather = CurrentWeather()
            currentWeather.downloadweatherdetails {
                self.downloadForecast {
                    self.updateUI()
                    self.mytabelview.reloadData()
                }
            }

        }
        else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mytabelview.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherViewCell{
            let forecast = Forecasts[indexPath.row]
            cell.updateUI(forecast: forecast)
            return cell
        }
        return WeatherViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Forecasts.count
    }
    
    func downloadForecast(completed: @escaping DownloadCompleted){
        let currenturl = URL(string: FORECAST_URL)!
        
        Alamofire.request(currenturl).responseJSON {
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for elem in list {
                       let forecast = Forecast(weatherData: elem)
                       self.Forecasts.append(forecast)
                    }
                    self.Forecasts.remove(at: 0)
                }
            }
            completed()
        }
        
    }
    
    func updateUI(){
        self.city.text = currentWeather.cityName
        self.todaydate.text = currentWeather.date
        self.degreetext.text = "\(currentWeather.currentTemp)°"
        self.weatherState.text = currentWeather._weatherType
        print("name city2 = \(currentWeather.cityName)\ntype weather2 = \(currentWeather.weatherType)\ncurrent Temp2 = \(currentWeather.currentTemp)")
        self.imageofweather.image = UIImage(named: currentWeather._weatherType)
    }
    



}

