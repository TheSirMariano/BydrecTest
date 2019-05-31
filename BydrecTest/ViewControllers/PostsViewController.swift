//
//  PostsViewController.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/28/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import UIKit
import Moya
import UIScrollView_InfiniteScroll

final class PostsViewController: UIViewController, Alertable {
  
  // MARK: - Properties
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
    didSet {
      collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
  }
  
  private var posts: [Post] = []
  private var currentPage: Int = 0

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    loadPosts()
  }
  
  // MARK: - Private
  private func loadPosts() {
    currentPage += 1
    SocialService.shared.getPostsByPage(currentPage, completion: { result in
      self.activityIndicator.stopAnimating()
      self.collectionView.finishInfiniteScroll()
      switch result {
      case .success(let posts):
        let firstIndexForInsertion = self.posts.count
        self.posts.append(contentsOf: posts)
        let indexes = Array(firstIndexForInsertion ... self.posts.count-1)
        let indexPaths = indexes.map({ return IndexPath(item: $0, section: 0 ) })
        self.collectionView.insertItems(at: indexPaths)
      case .failure(let err):
        self.currentPage -= 1
        self.showAlert(withTitle: "BydrecTest", message: err.localizedDescription, cancelTitle: "Ok", options: [])
      }
    })
  }
  
  func setUpView() {
    collectionView.addInfiniteScroll(handler: { [unowned self] tableView in
      self.loadPosts()
    })
  }
}

// MARK: - UICollectionViewDataSource
extension PostsViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseID, for: indexPath) as? PostCollectionViewCell else {
      assertionFailure("Missing cell for \(PostCollectionViewCell.reuseID)")
      return UICollectionViewCell()
    }
    cell.maxWidth = collectionView.bounds.size.width - 40
    
    let post = posts[indexPath.item]
    cell.viewModel = PostViewModel(post: post)
    
    return cell
  }
}

