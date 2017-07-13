//
//  Weather.swift
//  Wiko's Weather App
//
//  Created by Juan De La Rosa on 7/11/17.
//  Copyright © 2017 Juan De La Rosa. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Double
    let description: String
    
    //Convert Kelvin Temp to Celcius
    var tempF: Double {
        get {
            return (9/5 * (temp - 273) + 32)
        }
    }
    
    
    init(cityName: String, temp: Double, description: String)
    {
        self.cityName = cityName
        self.temp = temp
        self.description = description
    }
}