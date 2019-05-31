//
//  Text.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public struct Text: Decodable {
  public let markup: [Markup]
  public let plain: String
  
  public struct Markup: Decodable {
    public let length: Int
    public let location: Int
    public let link: URL
  }
}
