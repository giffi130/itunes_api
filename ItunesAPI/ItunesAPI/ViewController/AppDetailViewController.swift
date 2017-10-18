//
//  AppDetailViewController.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 16..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class AppDetailViewController: BaseViewController {
  
  var appID: String!
  var appDetail: AppDetail?
  
  let identifiers = ["HeaderCell", "ScreenshotCell", "DescriptionCell"]
  let cellHeights: [CGFloat] = [120, 440]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ConnectionManager.sharedInstance.getAppDetail(appID: appID) { (succeed, result) in
      guard succeed, let results = result?["results"] as? [JSONDictionary], results.count == 1
        else {
        self.showConfirmAlert(messageRes: "invalid_data")
          return
      }
      
      let resultDict = results[0]
      guard let imgURL = resultDict["artworkUrl100"] as? String,
        let appName = resultDict["trackName"] as? String,
        let rating = resultDict["averageUserRating"] as? Double,
        let scURLs = resultDict["screenshotUrls"] as? [String],
        let description = resultDict["description"] as? String else {
          self.showConfirmAlert(messageRes: "invalid_data")
          return
      }
      
      self.appDetail = AppDetail(name: appName, imageURL: imgURL, rating: rating, screenshotURLs: scURLs, description: description)
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension AppDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return identifiers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier = identifiers[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseAppDetailTableViewCell
    
    if let appDetail = self.appDetail {
      cell.configureCell(detail: appDetail)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row != 2 {
      return cellHeights[indexPath.row]
    } else {
      return tableView.estimatedRowHeight
    }
    
  }
}
