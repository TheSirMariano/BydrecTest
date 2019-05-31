//
//  Author.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public struct Author: Decodable {
  public let account: String?
  public let isVerified: Bool
  public let name: String
  public let pictureLink: URL?
  
  private enum CodingKeys: String, CodingKey {
    case account
    case isVerified = "is-verified"
    case name
    case pictureLink = "picture-link"
  }
}
