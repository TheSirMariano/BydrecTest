//
//  Alertable.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation
import UIKit

public typealias OptionCompletion = (() -> Void)

public protocol Alertable {

  func showAlert(withTitle title: String,
                 message: String,
                 cancelTitle: String,
                 options: [[String: OptionCompletion]])
  
  func showActionSheet(withTitle title: String?,
                       message: String?,
                       cancelTitle: String,
                       options: [[String: OptionCompletion]])
  
}

public extension Alertable where Self: UIViewController {

  // MARK: Public
  func showAlert(withTitle title: String,
                 message: String,
                 cancelTitle: String = "Cancel",
                 options: [[String: OptionCompletion]]) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    showAlertController(alertController,
                        withTitle: title,
                        message: message,
                        cancelTitle: cancelTitle,
                        options: options)
  }
  
  func showActionSheet(withTitle title: String? = nil,
                       message: String? = nil,
                       cancelTitle: String = "Cancel",
                       options: [[String: OptionCompletion]]) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    
    showAlertController(alertController, withTitle: title,
                        message: message,
                        cancelTitle: cancelTitle,
                        options: options)
  }
  
  // MARK: Private
  private func showAlertController(_ alertController: UIAlertController,
                                   withTitle title: String? = nil,
                                   message: String? = nil,
                                   cancelTitle: String = "Cancel",
                                   options: [[String: OptionCompletion]]?) {
    
    for option in options ?? [] {
      let key = option.keys.first
      let value = option.values.first
      let action = UIAlertAction(title: key, style: .default, handler: { alertAction in
        if value != nil {
          value!()
        }
      })
      alertController.addAction(action)
    }
    
    let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
    alertController.addAction(action)
    present(alertController, animated: true, completion: nil)
    
  }

}
