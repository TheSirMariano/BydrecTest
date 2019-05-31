//
//  PostCollectionViewCell.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/29/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import UIKit
import AlamofireImage

final class PostCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
  
  // MARK: - Properties
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var twitterNameLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var socialImageView: UIImageView!
  @IBOutlet weak var postTextLabel: UILabel!
  @IBOutlet weak var postImageView: UIImageView!
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet private var accountAndNameEqualHeightConstraint: NSLayoutConstraint! {
    didSet {
      accountAndNameEqualHeightConstraint.isActive = false
    }
  }
  
  @IBOutlet private var postTextMaxWidthConstraint: NSLayoutConstraint! {
    didSet {
      postTextMaxWidthConstraint.isActive = false
    }
  }
  @IBOutlet private var postImageViewWidthConstraint: NSLayoutConstraint! {
    didSet {
      postImageViewWidthConstraint.isActive = false
    }
  }
  
  @IBOutlet private var postImageViewHeightConstraint: NSLayoutConstraint! {
    didSet {
      postImageViewHeightConstraint.isActive = false
    }
  }
  
  public var viewModel: PostViewModel? {
    didSet {
      guard let viewModel = viewModel else {
        return
      }
      setUpForViewModel(viewModel)
    }
  }
  
  public var maxWidth: CGFloat? = nil {
    didSet {
      guard let maxWidth = maxWidth else {
        return
      }
      postTextMaxWidthConstraint.isActive = true
      postTextMaxWidthConstraint.constant = maxWidth
      
      postImageViewWidthConstraint.isActive = true
      postImageViewWidthConstraint.constant = maxWidth
    }
  }
  
  // MARK: - Override
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpView()
  }
  
  // MARK: - Private
  private func setUpView() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: leftAnchor),
      contentView.rightAnchor.constraint(equalTo: rightAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.black.cgColor
    contentView.layer.cornerRadius = 15
    contentView.layer.masksToBounds = true
    
    profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
    profileImageView.layer.masksToBounds = true
  }
  
  private func setUpForViewModel(_ viewModel: PostViewModel) {
    userNameLabel.text = viewModel.userName
    postTextLabel.text = viewModel.postText
    dateLabel.text = viewModel.postDate
    socialImageView.image = UIImage(named: viewModel.networkImageName)
    
    setUpVerifiedAccount(forViewModel: viewModel)
    setUpAttachment(forViewModel: viewModel)
    
    if let profileImageUrl = viewModel.profileImageUrl {
      profileImageView.af_setImage(withURL: profileImageUrl)
    }
  }
  
  private func setUpVerifiedAccount(forViewModel viewModel: PostViewModel) {
    twitterNameLabel.text = viewModel.accountName
    if viewModel.isVerified {
      
      let fullString = NSMutableAttributedString(string: "\(viewModel.accountName) ")
      
      let checkImageAttachment = NSTextAttachment()
      checkImageAttachment.image = UIImage(named: viewModel.verifiedImageName)
      checkImageAttachment.bounds.size = CGSize(width: 20, height: 20)
      
      let checkString = NSAttributedString(attachment: checkImageAttachment)
      
      fullString.append(checkString)
      
      let firstRange = NSMakeRange(0, viewModel.accountName.count + 1)
      let imageRange = NSMakeRange(firstRange.length, 1)
      
      fullString.beginEditing()
      fullString.addAttribute(.baselineOffset, value: -3, range: imageRange)
      fullString.endEditing()
      
      twitterNameLabel.attributedText = fullString
      
      accountAndNameEqualHeightConstraint.isActive = true
    } else {
      accountAndNameEqualHeightConstraint.isActive = false
    }
  }
  
  private func setUpAttachment(forViewModel viewModel: PostViewModel) {
    if let attachment = viewModel.attachment {
      let maxW = maxWidth ?? 0
      let expectedHeight = maxW * CGFloat(attachment.ratio)
      
      postImageViewHeightConstraint.constant = expectedHeight
      postImageViewHeightConstraint.isActive = true
      
      postImageView.af_setImage(withURL: attachment.link)
    } else {
      postImageViewHeightConstraint.constant = 0
      postImageViewHeightConstraint.isActive = true
    }
  }
  
}


