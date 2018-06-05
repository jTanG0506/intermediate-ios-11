//
//  KivaLoanTableViewController.swift
//  KivaLoan
//
//  Created by Jonathan Tang on 5/06/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
  
  private let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
  private var loans = [Loan]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 92.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    getLatestLoans()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Data retrieval
  
  func getLatestLoans() {
    guard let loanUrl = URL(string: kivaLoanURL) else {
      return
    }
    
    let request = URLRequest(url: loanUrl)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
        return
      }
      
      // Parse JSON data
      if let data = data {
        self.loans = self.parseJsonData(data: data)
        
        // Reload table view
        OperationQueue.main.addOperation {
          self.tableView.reloadData()
        }
      }
    }
    
    task.resume()
  }
  
  func parseJsonData(data: Data) -> [Loan] {
    var loans = [Loan]()
    let decoder = JSONDecoder()
    
    do {
      let loanDataStore = try decoder.decode(LoanDataStore.self, from: data)
      loans = loanDataStore.loans
    } catch {
      print(error)
    }
    
    return loans
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return loans.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KivaLoanTableViewCell
    
    cell.nameLabel.text = loans[indexPath.row].name
    cell.countryLabel.text = loans[indexPath.row].country
    cell.useLabel.text = loans[indexPath.row].use
    cell.amountLabel.text = "£\(loans[indexPath.row].amount)"
    
    return cell
  }
  
}
