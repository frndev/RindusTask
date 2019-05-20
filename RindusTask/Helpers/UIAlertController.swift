//
//  UIAlertController.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 17/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  static func promptAlert(title: String, message: String, completion: @escaping (UITextField) -> Void) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addTextField {
      $0.placeholder = "Insert new album"
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let acceptAction = UIAlertAction(title: "Send", style: .default) { _ in
      guard let textField = alertController.textFields?[0] else { return }
      completion(textField)
    }
    alertController.addAction(cancelAction)
    alertController.addAction(acceptAction)
    return alertController
    
  }
  
  static func errorAlert() -> UIAlertController {
    let alertController = UIAlertController(title: "Error", message: "We could not proceed this action", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    return alertController
  }
  
}

extension UIViewController {
  func showErrorAlert() {
    let alert = UIAlertController.errorAlert()
    present(alert, animated: true, completion: nil)
  }
}
