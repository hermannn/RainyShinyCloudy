//
//  WeatherViewCell.swift
//  RainyShinyCloudy
//
//  Created by Hermann Dorio on 08/10/2016.
//  Copyright © 2016 Hermann Dorio. All rights reserved.
//

import UIKit

class WeatherViewCell: UITableViewCell {

    @IBOutlet weak var degreeMin: UILabel!
    @IBOutlet weak var degreeMax: UILabel!
    @IBOutlet weak var stateWeather: UILabel!
    @IBOutlet weak var myday: UILabel!
    @IBOutlet weak var myimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(forecast: Forecast){
        self.degreeMin.text = forecast.minTemp
        self.degreeMax.text = forecast.maxTemp
        self.myday.text = forecast.todayDate
        self.stateWeather.text = forecast.weatherState
        self.myimage.image = UIImage(named: forecast.weatherState)
    }
    

}
