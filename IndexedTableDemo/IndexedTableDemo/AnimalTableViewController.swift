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
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return animals.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    // Configure the cell...
    cell.textLabel?.text = animals[indexPath.row]
    
    // Convert the animal name to lower case and
    // then replace all occurences of a space with an underscore
    let imageFileName = animals[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
    cell.imageView?.image = UIImage(named: imageFileName)
    
    return cell
  }
  
}
