//
//  LocationTableViewController.swift
//  WeatherDemo
//
//  Created by Jonathan Tang on 13/04/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
  
  let locations = ["Paris, France", "Kyoto, Japan", "Sydney, Australia", "Seattle, U.S.",
                   "New York, U.S.", "Hong Kong, Hong Kong", "Taipei, Taiwan", "London, U.K.", "Vancouver, Canada"]
  
  var selectedLocation = "" {
    didSet {
      var locations = selectedLocation.split { $0 == "," }.map { String($0) }
      
      selectedCity = locations[0]
      selectedCountry = locations[1].trimmingCharacters(in: .whitespacesAndNewlines)
    }
  }
  
  private(set) var selectedCity = ""
  private(set) var selectedCountry = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    // Configure the cell...
    cell.textLabel?.text = locations[indexPath.row]
    cell.accessoryType = (locations[indexPath.row] == selectedLocation) ? .checkmark : .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
    if let location = cell?.textLabel?.text {
      selectedLocation = location
    }
    
    tableView.reloadData()
  }
}
