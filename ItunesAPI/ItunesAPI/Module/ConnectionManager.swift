//
//  ConnectionManager.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 15..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String : Any]

enum iTunesGenre: Int {
  case Finance = 6015
}

enum Errors: Error{
  case InvalidURL
  case InvalidData
  case Network
  case JSONParse
}

class ConnectionManager: NSObject {
  static let sharedInstance = ConnectionManager()
  
  private let BASE_URL = "https://itunes.apple.com/"
  private let TOP_FREE_LIST_URL = "kr/rss/topfreeapplications/limit=%d/genre=%d/json"
  private let APP_DETAIL_URL = "lookup?id=%@&country=kr"
  
  typealias CompletionHandler = (_ succeed: Bool, _ result: JSONDictionary?, _ error: Errors?) -> Void
  typealias ImageHandler = (_ data: Data?, _ error: Errors?) -> Void
  
  func getTopFreeList(limit: Int, genre: iTunesGenre, completionHanlder: @escaping CompletionHandler) {
    let topListURL = String.init(format: TOP_FREE_LIST_URL, limit, genre.rawValue)
    
    request(requestURL: topListURL, completionHandler: completionHanlder)
  }
  
  func getAppDetail(appID: String, completionHandler: @escaping CompletionHandler) {
    let detailURL = String.init(format: APP_DETAIL_URL, appID)
    
    request(requestURL: detailURL, completionHandler: completionHandler)
  }
}

extension ConnectionManager {
  func imageRequest(requestURL: String, completionHandler: @escaping ImageHandler) {
    guard let url = URL(string: requestURL) else {
      completionHandler(nil, .InvalidURL)
      return
    }
    
    URLSession.shared.dataTask(with: url) {
      data, response, error in
      
      completionHandler(data, nil)
    }.resume()
  }
  
  fileprivate func request(requestURL: String, completionHandler: @escaping CompletionHandler) {
    guard let url = URL(string: BASE_URL + requestURL) else {
      completionHandler(false, nil, .InvalidURL)
      return
    }
    
    URLSession.shared.dataTask(with: url) {
      data, response, error in
      
      if let _ = error {
        completionHandler(false, nil, .Network)
      } else if let httpResponse = response as? HTTPURLResponse,
        let data = data {
        if httpResponse.statusCode == 200 {
          var response: JSONDictionary?
          
          do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
          } catch _ as NSError {
            completionHandler(false, nil, .JSONParse)
            return
          }
          
          completionHandler(true, response, nil)
        }
      }
      }.resume()
  }
}
