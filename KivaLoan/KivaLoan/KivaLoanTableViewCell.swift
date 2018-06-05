//
//  KivaLoanTableViewCell.swift
//  KivaLoan
//
//  Created by Jonathan Tang on 5/06/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel:UILabel! {
    didSet {
      nameLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet weak var countryLabel:UILabel! {
    didSet {
      countryLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet weak var useLabel:UILabel! {
    didSet {
      useLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet weak var amountLabel:UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
