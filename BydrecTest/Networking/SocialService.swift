//
//  SocialService.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation
import Moya

public enum Result<T> {
  case success([Post])
  case failure(Error)
}

public final class SocialService {
  
  public static let shared: SocialService = SocialService()
  
  private init() {
    // DO NOTHING
  }
  
  public func getPostsByPage(_ page: Int,
                             completion: @escaping ((_ result: Result<[Post]>) -> Void)) {
    let provider = MoyaProvider<SocialEndpoint>()
    provider.request(.postsByPage(1), completion: { result in
      switch result {
      case .success(let value):
        do {
          let posts = try JSONDecoder().decode([Post].self, from: value.data)
          completion(.success(posts))
        } catch(let err) {
          completion(.failure(err))
        }
      case .failure(let err):
        completion(.failure(err))
      }
    })
  }
  
  
  
}
