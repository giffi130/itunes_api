//
//  BaseViewController.swift
//  ItunesAPI
//
//  Created by Hyeonjin Jang on 2017. 10. 18..
//  Copyright © 2017년 KakaoBank. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showErrorAlert(error: Errors) {
    var errorMessage = "unknown_error"
    
    switch error {
    case .InvalidData:
      errorMessage = "invalid_data_error"
    case .InvalidURL:
      errorMessage = "invalid_url_error"
    case .JSONParse:
      errorMessage = "json_Parse_error"
    case .Network:
      errorMessage = "network_error"
    }
    
    let alert = UIAlertController(title: String.l("error"), message: String.l(errorMessage), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: String.l("confirm"), style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
