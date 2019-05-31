//
//  PostViewModel.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/29/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public typealias PostAttachment = (ratio: Double, link: URL)
public typealias TextMarkup = (length: Int, location: Int, link: URL)

public struct PostViewModel {
  
  // MARK: - Properties
  private let post: Post
  
  public let profileImageUrl: URL?
  public let accountName: String
  public let isVerified: Bool
  public let userName: String
  public let postText: String
  public let markups: [TextMarkup]?
  public let postDate: String
  public let networkImageName: String
  
  private let postImageUrl: URL?
  private let postImageWidth: Int?
  private let postImageHeight: Int?
  
  public var verifiedImageName: String {
    if isVerified {
      return "success"
    }
    return "error"
  }
  
  public var attachment: PostAttachment? {
    if postImageUrl == nil {
      return nil
    }
    if postImageWidth == nil || postImageHeight == nil {
      return nil
    }
    if postImageWidth == 0 || postImageHeight == 0 {
      return nil
    }
    let ratio = Double(postImageHeight!)/Double(postImageWidth!)
    return PostAttachment(ratio, postImageUrl!)
  }
  
  // MARK: - Initializer
  init(post: Post) {
    self.post = post
    
    profileImageUrl = post.author.pictureLink
    accountName = post.author.account == nil ? "" : "@\(post.author.account!)"
    isVerified = post.author.isVerified
    userName = post.author.name
    postImageUrl = post.attachment?.pictureLink
    postImageWidth = post.attachment?.width
    postImageHeight = post.attachment?.height
    networkImageName = post.networkType.imageName
    postText = post.text?.plain ?? ""
    markups = post.text?.markup.map({ return TextMarkup($0.length, $0.location, $0.link )})
    
    guard let serverDate = DateFormatterFactory.shared.serverDateFormatter.date(from: post.date) else {
      postDate = ""
      return
    }
    postDate = DateFormatterFactory.shared.appDateFormatter.string(from: serverDate)
    
  }
  
  
}

extension Date {
  
  // Convert local time to UTC (or GMT)
  func toGlobalTime() -> Date {
    let timezone = TimeZone.current
    let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
  }
  
  // Convert UTC (or GMT) to local time
  func toLocalTime() -> Date {
    let timezone = TimeZone.current
    let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
  }
  
}
