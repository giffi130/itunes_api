//
//  AppListViewController.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 15..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class AppListViewController: BaseViewController {
  
  var apps = [App]()
  let detailIdentifier = "toDetail"
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ConnectionManager.sharedInstance.getTopFreeList(limit: 50, genre: .Finance, completionHanlder: {
      succeed, result, error in
      
      if let error = error {
        super.showErrorAlert(error: error)
        return
      }
      
      guard succeed, let feedDict = result?["feed"] as? JSONDictionary,
        let titleDict = feedDict["title"] as? JSONDictionary,
        let label = titleDict["label"] as? String,
        let entry = feedDict["entry"] as? [JSONDictionary] else {
          self.showErrorAlert(error: .InvalidData)
          return
      }
      
      DispatchQueue.main.async {
        self.title = label
      }
      
      for item in entry {
        guard let _id = item["id"] as? JSONDictionary,
          let attributes = _id["attributes"] as? JSONDictionary,
          let nameDict = item["im:name"] as? JSONDictionary,
          let appLabel = nameDict["label"] as? String,
          let appID = attributes["im:id"] as? String,
          let imageDict = item["im:image"] as? [JSONDictionary],
          let summaryDict = item["summary"] as? JSONDictionary,
          let description = summaryDict["label"] as? String,
          let imageURL = imageDict[0]["label"] as? String else {
            
            continue
        }
        
        let app = App(name: appLabel, appID: appID, imageURL: imageURL, desc: description)
        self.apps.append(app)
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == detailIdentifier {
      let backItem = UIBarButtonItem()
      backItem.title = String.l("navigation_back")
      backItem.tintColor = UIColor.black
      navigationItem.backBarButtonItem = backItem
      
      let destVC = segue.destination as! AppDetailViewController
      let selectedRow = tableView.indexPathForSelectedRow?.row
      destVC.appID = apps[selectedRow!].appID
    }
  }
}

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: detailIdentifier, sender: self)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return AppListTableViewCell.CELL_HEIGHT
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: AppListTableViewCell.CELL_IDENTIFIER) as! AppListTableViewCell
    
    cell.configureCell(app: apps[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return apps.count
  }
}
