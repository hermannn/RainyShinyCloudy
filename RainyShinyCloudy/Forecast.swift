//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import Foundation


class Forecast {
    var _minTemp:String!
    var _maxTemp:String!
    var _todayDate:String!
    var _weatherState:String!
    
    var minTemp:String {
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }

    var maxTemp:String {
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }

    var todayDate:String {
        if _todayDate == nil {
            _todayDate = ""
        }
        return _todayDate
    }

    var weatherState:String {
        if _weatherState == nil {
            _weatherState = ""
        }
        return _weatherState
    }
    
    init(weatherData: Dictionary<String,AnyObject>) {
        if let temp = weatherData["temp"] as? Dictionary<String, AnyObject> {
            if let maxT = temp["max"] as? Double {
                let celsiusvalue = kelvintoCelsius(kelvintemp: maxT)
                self._maxTemp = "\(celsiusvalue)"
            }
            
            if let minT = temp["min"] as? Double {
                let celsiusvalue = kelvintoCelsius(kelvintemp: minT)
                self._minTemp = "\(celsiusvalue)"
            }
        }
        
        if let weather  = weatherData["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherState = main
            }
        }
        
        if let date = weatherData["dt"] as? Double {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = NSLocale(localeIdentifier: "en_UK") as Locale!
            let mdate = Date(timeIntervalSince1970: date)
            let day = dateFormatter.string(from: mdate)
            self._todayDate = day
        }
    }
    
    func kelvintoCelsius (kelvintemp: Double)  -> Double{
        let celsiusTemp = Double(round(kelvintemp - 273.15))
        return celsiusTemp
    }

    
}
