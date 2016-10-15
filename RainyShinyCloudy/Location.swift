//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Hermann Dorio on 10/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude:Double!
    var longitude:Double!
    
}
