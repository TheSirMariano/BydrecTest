//
//  Post.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/29/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public enum NetworkType: String {
  case twitter, facebook, instagram, unknown
  
  public var imageName: String {
    switch self {
    case .twitter:
      return "twitter"
    case .facebook:
      return "facebook"
    case .instagram:
      return "instagram"
    default:
      return ""
    }
  }
}

public struct Post: Decodable {
  public let author: Author
  public let date: String
  public let link: URL?
  public let text: Text?
  public let attachment: Attachment?
  private let network: String
  
  public var networkType: NetworkType {
    return NetworkType(rawValue: network) ?? .unknown
  }
}
