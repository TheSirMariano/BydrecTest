//
//  SocialService.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/30/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation
import Moya

public enum SocialEndpoint: TargetType {
  
  public var baseURL: URL {
    return URL(string: Constants.API.baseUrl)!
  }
  
  public var path: String {
    switch self {
    case .postsByPage(let page):
      return "/social/\(page).json"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .postsByPage(_):
      return .get
    }
  }
  
  public var sampleData: Data {
    switch self {
    case .postsByPage(_):
      return "{}".data(using: .utf8) ?? Data()
    }
  }
  
  public var task: Task {
    switch self {
    case .postsByPage(_):
      return .requestPlain
    }
  }
  
  public var headers: [String : String]? {
    return nil
  }
  
  case postsByPage(_ page: Int)
}
