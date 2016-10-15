//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Hermann Dorio on 08/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import Foundation

typealias DownloadCompleted = () -> ()
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid=6244b881fddc9a5b34b875aeefde24ce"

let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"


let CURRENT_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)"
let FORECAST_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)"
