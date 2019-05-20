//
//  PostsListsViewController.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Models
import Core

protocol PostsListViewControllerInterface {
  func displayPosts(viewModel: PostsListModels.GetPosts.ViewModel)

}

final class PostsListViewController: UIViewController, PostsListViewControllerInterface {
  
  static var storyboardID = String(describing: PostsListViewController.self)
  
  @IBOutlet weak var collectionView: UICollectionView!

  var interactor: PostsListInteractorInterface!
  var router: PostsListRouterInterface!
  
  var posts: [Post] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let width = UIScreen.main.bounds.size.width - 52
    layout.estimatedItemSize = CGSize(width: width, height: 80)
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
    layout.minimumLineSpacing = 20
    return layout
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Posts"
    let nib = UINib(nibName: PostListCollectionViewCell.identifier, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: PostListCollectionViewCell.identifier)
    collectionView.collectionViewLayout = layout
    interactor.getPosts(request: PostsListModels.GetPosts.Request())
  }
  
  private func showReloadButton() {
    let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(PostsListViewController.didTapReloadButton))
    navigationItem.rightBarButtonItem = reloadButton
  }
  
  private func hideReloadButton() {
    navigationItem.rightBarButtonItem = nil
  }
  
  @objc func didTapReloadButton() {
    interactor.getPosts(request: PostsListModels.GetPosts.Request())
  }
  
  func displayPosts(viewModel: PostsListModels.GetPosts.ViewModel) {
    switch viewModel.content {
    case .loading:
      showLoader()
    case .success(let data):
      hideReloadButton()
      hideLoader()
      posts = data
    case .error:
      hideLoader()
      showErrorAlert()
      showReloadButton()
    default:
      break
    }
  }
  
}

extension PostsListViewController {
  fileprivate func configure() {
    let interactor = PostsListInteractor()
    let presenter = PostsListPresenter()
    let router = PostsListRouter()
    let worker = PostsRestWorker()
    
    interactor.presenter = presenter
    interactor.postWorker = worker
    presenter.viewController = self
    router.viewController = self
    
    self.interactor = interactor
    self.router = router
    
  }
}

extension PostsListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostListCollectionViewCell.identifier, for: indexPath) as! PostListCollectionViewCell
    
    let post = posts[indexPath.row]
    let cellData = PostListCollectionViewCellData(title: post.title, description: post.body)
    cell.configure(with: cellData)
    
    return cell
  }
  
}
