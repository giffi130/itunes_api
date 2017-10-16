//
//  AppListViewController.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 15..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class App {
  var name: String
  
  init(name: String) {
    self.name = name
  }
}

class AppListViewController: UIViewController {
  
  var apps = [App]()
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ConnectionManager.sharedInstance.getTopFreeList(limit: 50, genre: .Finance, completionHanlder: {
      success, result in
      
      guard let feed = result?["feed"] as? NSDictionary,
        let entry = feed["entry"] as? [NSDictionary] else {
        preconditionFailure()
      }
      
      for item in entry {
        guard let dictItem = item as? NSDictionary,
          let imName = dictItem["im:name"] as? NSDictionary,
          let label = imName["label"] as? String else{
          preconditionFailure()
        }
        
        self.apps.append(App(name: label))
      }
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: Show App Detail
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return AppListTableViewCell.CELL_HEIGHT
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AppListTableViewCell.CELL_IDENTIFIER) as? AppListTableViewCell else {
      // TODO
      preconditionFailure()
    }
    
    cell.configureCell(app: apps[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return apps.count
  }
}
