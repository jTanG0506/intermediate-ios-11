//
//  KivaLoanTableViewController.swift
//  KivaLoan
//
//  Created by Jonathan Tang on 5/06/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 92.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // Return the number of sections
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows
    return 0
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KivaLoanTableViewCell
    
    // Configure the cell...
    
    return cell
  }
  
}
