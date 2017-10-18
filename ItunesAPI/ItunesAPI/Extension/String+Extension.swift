//
//  String+Extension.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 18..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

extension String {
  static func l(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
  }  
}
