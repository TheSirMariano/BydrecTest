//
//  Attachment.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public struct Attachment: Decodable {
  public let pictureLink: URL?
  public let width: Int
  public let height: Int
  
  private enum CodingKeys: String, CodingKey {
    case pictureLink = "picture-link"
    case width
    case height
  }
}
