//
//  WeatherService.swift
//  Wiko's Weather App
//
//  Created by Juan De La Rosa on 7/11/17.
//  Copyright © 2017 Juan De La Rosa. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
    func weatherErrorWithMessage(message: String)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let appid = "2467d46a5e4299f20b4dffdd7c17439b"
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appid)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            //print(">>> \(data!)")
            
            let json = JSON(data: data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            let desc = json["weather"][0]["description"].string
            let icon = json["weather"][0]["icon"].string
            
             
            
            let weather = Weather(cityName: name!, temp: temp!, description: desc!, icon: icon!)
            
            if self.delegate != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.delegate?.setWeather(weather)
                })
            }
            
            print("Lat: \(lat!) lon: \(lon!) temp: \(temp!) ")
        }
        
        task.resume()
        
                 
        
        /*print("Weather Service city: \(city)")
        // request weather data
        // wait...
        // process date
        
        let weather = Weather(cityName: city, temp: 237.12, description: "A nice day!")
        
        if delegate != nil {
            delegate?.setWeather(weather)
        }
        */
        
    }
    
}