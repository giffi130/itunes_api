//
//  AppDetailHeaderTableViewCell.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 17..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class AppDetailHeaderTableViewCell: BaseAppDetailTableViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var ratingSubView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func configureCell(detail: AppDetail) {
    titleLabel.text = detail.name
    iconImageView.setImage(withURL: detail.imageURL)
    
    let intRating = Int(round(detail.rating))
    ratingLabel.text = "\(detail.rating)"
    for subview in ratingSubView.subviews{
      if let imgView = subview as? UIImageView {
        if imgView.tag <= intRating + 100 {
          imgView.isHighlighted = true
        }
      }
    }
  }
}
