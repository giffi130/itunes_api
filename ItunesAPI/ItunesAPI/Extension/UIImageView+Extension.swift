//
//  UIImage+Extension.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 16..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

extension UIImageView {
  func setImage(withURL url: String) {
    
    ConnectionManager.sharedInstance.imageRequest(requestURL: url) { (data, errors) in
      guard let _data = data else {
        return
      }
      
      DispatchQueue.main.async {
        self.image = UIImage(data: _data)
      }
    }
  }
}
