//
//  App.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 16..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import Foundation


class App {
  var name: String
  var appID: String
  var imageURL: String
  var description: String
  
  init(name: String, appID: String, imageURL: String, desc: String) {
    self.name = name
    self.appID = appID
    self.imageURL = imageURL
    self.description = desc
  }
}
