//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Jonathan Tang on 16/04/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
  
  // MARK: - Outlets
  @IBOutlet var cityLabel: UILabel!
  @IBOutlet var weatherLabel: UILabel!
  @IBOutlet var temperatureLabel: UILabel!
  
  private var city = "Paris"
  private var country = "France"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cityLabel.text = "\(city), \(country)"
    
    // Invoke weather service to get the weather data
    WeatherService.sharedWeatherService().getCurrentWeather(location: city) { (data) in
      OperationQueue.main.addOperation {
        if let weatherData = data {
          self.weatherLabel.text = weatherData.weather.capitalized
          self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    cityLabel.text = city
    
    WeatherService.sharedWeatherService().getCurrentWeather(location: city) { (data) in
      guard let weatherData = data else {
        completionHandler(NCUpdateResult.noData)
        return
      }
      
      OperationQueue.main.addOperation {
        self.weatherLabel.text = weatherData.weather.capitalized
        self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
      }
      
      completionHandler(NCUpdateResult.newData)
    }
  }
  
}
