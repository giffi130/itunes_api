//
//  BaseAppDetailTableViewCell.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 17..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class BaseAppDetailTableViewCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    
  }
  
  func configureCell(detail: AppDetail){
    preconditionFailure("This method must override")
  }
}
