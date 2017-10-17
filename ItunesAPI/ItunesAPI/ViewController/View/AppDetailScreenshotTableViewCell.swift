//
//  AppDetailScreenshotTableViewCell.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 17..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class AppDetailScreenshotTableViewCell: BaseAppDetailTableViewCell {
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func configureCell(detail: AppDetail) {
    let imgWidth = 220
    let imgHeight = 400
    
    for (i, url) in detail.screenshotURLs.enumerated() {
      let imgView = UIImageView(frame: CGRect(x: imgWidth * i, y: 0, width: imgWidth, height: imgHeight))
      imgView.setImage(withURL: url)
      scrollView.addSubview(imgView)
    }
    
    scrollView.contentSize = CGSize(width: CGFloat(imgWidth * detail.screenshotURLs.count), height:scrollView.frame.height)
  }
}
