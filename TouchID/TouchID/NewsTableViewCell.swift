//
//  NewsTableViewCell.swift
//  TouchID
//
//  Created by Jonathan Tang on 5/06/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  
  @IBOutlet var postImageView: UIImageView!
  @IBOutlet var postTitle: UILabel!
  @IBOutlet var postAuthor: UILabel!
  @IBOutlet var authorImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Initialization code
    
    authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
    authorImageView.layer.masksToBounds = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
