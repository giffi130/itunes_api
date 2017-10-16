//
//  AppListTableViewCell.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 16..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class AppListTableViewCell: UITableViewCell {
  
  static let CELL_HEIGHT: CGFloat = 100
  static let CELL_IDENTIFIER = "Cell"
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureCell(app: App){
    nameLabel.text = app.name
    iconImageView.setImage(withURL: app.imageURL)
  }
}
