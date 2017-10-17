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

class ConnectionManager: NSObject {
  static let sharedInstance = ConnectionManager()
  
  private let BASE_URL = "https://itunes.apple.com/"
  private let TOP_FREE_LIST_URL = "kr/rss/topfreeapplications/limit=%d/genre=%d/json"
  private let APP_DETAIL_URL = "lookup?id=%@&country=kr"
  
  typealias CompletionHandler = (_ succeed: Bool, _ result: JSONDictionary?) -> Void
  typealias ImageHandler = (_ data: Data?) -> Void
  
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
      preconditionFailure()
    }
    
    URLSession.shared.dataTask(with: url) {
      data, response, error in
      
      completionHandler(data)
    }.resume()
  }
  
  fileprivate func request(requestURL: String, completionHandler: @escaping CompletionHandler) {
    guard let url = URL(string: BASE_URL + requestURL) else {
      preconditionFailure()
    }
    
    URLSession.shared.dataTask(with: url) {
      data, response, error in
      
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse,
        let data = data {
        if httpResponse.statusCode == 200 {
          var response: JSONDictionary?
          
          do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
          } catch let jsonError as NSError {
            // TODO : Error Handling
            completionHandler(false, nil)
            return
          }
          
          // TODO : Call Handler
          completionHandler(true, response)
        }
      }
      }.resume()
  }
}
