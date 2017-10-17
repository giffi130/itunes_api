//
//  AppDetailDescriptionTableViewCell.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 17..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class AppDetailDescriptionTableViewCell: BaseAppDetailTableViewCell {
  
  @IBOutlet weak var descriptionLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func configureCell(detail: AppDetail) {
    descriptionLabel.text = detail.description
  }
}
