//
//  ViewController.swift
//  Wiko's Weather App
//
//  Created by Juan De La Rosa on 7/11/17.
//  Copyright © 2017 Juan De La Rosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    
    let weatherService = WeatherService()
    
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    //@IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    @IBAction func setCityTapped(sender: UIButton) {
        print("City Button Tapped")
        openCityAlert()
    }
    
    
    
    func openCityAlert() {
        // Create Alert Controller
        let alert = UIAlertController(title: "City", message: "Enter city name", preferredStyle: .Alert)
        
        // Create Cancel Action
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        // Create OK Action
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
            print("OK")
            let textField = alert.textFields?[0]
            print(textField?.text)
            //self.cityLabel.text = textField?.text!
            let cityName = textField?.text!
            self.weatherService.getWeather(cityName!)
        }
        
        alert.addAction(ok)
        
        // Add Text Field
        alert.addTextFieldWithConfigurationHandler { (testField: UITextField) in
            testField.placeholder = "City Name"
        }
        
        // Present Alert Controller
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // Mark: - Weather Service Delegate Methods
    
    func setWeather(weather: Weather) {
        //print("*** Set Weather")
        //print("City: \(weather.cityName) temp: \(weather.temp) description: \(weather.description)")
        //cityLabel.text = weather.cityName
        tempLabel.text = " \(weather.tempC)˚"
        descriptionLabel.text = weather.description
        cityButton.setTitle(weather.cityName, forState: .Normal)
        iconImage.image = UIImage(named: weather.icon)
    }
    
    func weatherErrorWithMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

