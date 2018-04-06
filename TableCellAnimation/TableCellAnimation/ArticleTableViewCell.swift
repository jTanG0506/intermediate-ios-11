//
//  ArticleTableViewCell.swift
//  TableCellAnimation
//
//  Created by Jonathan Tang on 06/04/2018.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel:UILabel!
  @IBOutlet weak var postImageView:UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
