//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Jonathan Tang on 21/03/2018.
//  Copyright © 2016 jtang0506. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
  
  // MARK: - Properties
  let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
  
  let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  
  var animalsDict = [String: [String]]()
  var animalsSectionTitles = [String]()
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Generate the animal dictionary.
    createAnimalDict()
  }
  
  func createAnimalDict() {
    for animal in animals {
      // Get the first letter of the animals name to build the dictionary
      let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
      let animalKey = String(animal[..<firstLetterIndex])
      
      // Either add the animal to the array if it exists, or create a new array.
      if var animalValues = animalsDict[animalKey] {
        animalValues.append(animal)
        animalsDict[animalKey] = animalValues
      } else {
        animalsDict[animalKey] = [animal]
      }
    }
    
    // Get the section titles from dictionarys keys and sort them in ascending order.
    animalsSectionTitles = [String](animalsDict.keys)
    animalsSectionTitles.sort(by: { $0 < $1 })
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    // Return the number of sections.
    return animalsSectionTitles.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    let animalKey = animalsSectionTitles[section]
    
    guard let animalValues = animalsDict[animalKey] else {
      return 0
    }
    
    return animalValues.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return animalsSectionTitles[section]
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    // Configure the cell...
    let animalKey = animalsSectionTitles[indexPath.section]
    if let animalValues = animalsDict[animalKey] {
      cell.textLabel?.text = animalValues[indexPath.row]
      
      // Convert the animal name to lower case and
      // then replace all occurences of a space with an underscore
      let imageFileName = animalValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
      cell.imageView?.image = UIImage(named: imageFileName)
    }
    
    return cell
  }
  
  override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return animalIndexTitles
  }
  
  override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String,
                          at index: Int) -> Int {
    guard let index = animalsSectionTitles.index(of: title) else {
      return -1
    }
    
    return index
  }
  
}
