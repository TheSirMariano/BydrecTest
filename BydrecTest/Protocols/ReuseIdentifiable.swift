//
//  ReuseIdentifiable.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/29/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public protocol ReuseIdentifiable {
  static var reuseID: String { get }
}

public extension ReuseIdentifiable {
  static var reuseID: String {
    return String(describing: self)
  }
}
