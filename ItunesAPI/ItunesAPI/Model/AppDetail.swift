//
//  AppDetail.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 17..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import Foundation

class AppDetail {
  var name: String
  var imageURL: String
  var rating: Double
  var screenshotURLs: [String]
  
  init(name: String, imageURL: String, rating: Double, screenshotURLs: [String]) {
    self.name = name
    self.imageURL = imageURL
    self.rating = rating
    self.screenshotURLs = screenshotURLs
  }
}
