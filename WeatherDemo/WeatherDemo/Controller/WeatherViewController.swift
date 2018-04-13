//
//  WeatherViewController.swift
//  WeatherDemo
//
//  Created by Jonathan Tang on 13/04/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  @IBOutlet var cityLabel: UILabel!
  @IBOutlet var countryLabel: UILabel!
  @IBOutlet var weatherLabel: UILabel!
  @IBOutlet var temperatureLabel: UILabel!
  
  var city = "Paris"
  var country = "France"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    weatherLabel.text = ""
    temperatureLabel.text = ""
    
    displayCurrentWeather()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func displayCurrentWeather() {
    cityLabel.text = city
    countryLabel.text = country
    
    // Invoke weather service to get the weather data
    WeatherService.sharedWeatherService().getCurrentWeather(location: city, completion: { (data) -> () in
      OperationQueue.main.addOperation({ () -> Void in
        if let weatherData = data {
          self.weatherLabel.text = weatherData.weather.capitalized
          self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
        }
      })
    })
  }
  
  // MARK: - Action methods
  
  @IBAction func unwindToHome(segue: UIStoryboardSegue) {}
  
  @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
    let sourceViewController = segue.source as! LocationTableViewController
    
    city = sourceViewController.selectedCity
    country = sourceViewController.selectedCountry
    
    displayCurrentWeather()
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showLocations" {
      let destinationController = segue.destination as! UINavigationController
      let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
      locationTableViewController.selectedLocation = "\(city), \(country)"
    }
  }
  
}
