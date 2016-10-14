//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Hermann Dorio on 08/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import Foundation
import Alamofire


class CurrentWeather {
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp:Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentdate = dateFormatter.string(from: Date())
        
        self._date = "Today, \(currentdate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadweatherdetails (completed: @escaping DownloadCompleted) {
        let currenturl = URL(string: CURRENT_URL)!
        
        //print(CURRENT_URL)
        Alamofire.request(currenturl).responseJSON { response in
            let result = response.result
            print(result.value)
            if let dict =  result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let kelvintemp = main["temp"] as? Double {
                        let celsiusTemp = Double(round(kelvintemp - 273.15))
                        self._currentTemp = celsiusTemp
                    }
                }
                
               // print("name city = \(self.cityName)\ntype weather = \(self.weatherType)\ncurrent Temp = \(self.currentTemp)")
            }
             completed()
        }
    }
    
}
