//
//  PhotoGalleryViewController.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Core
import Models

enum PhotoState {
  case collection
  case list
}

protocol PhotoGalleryViewControllerInterface {
  func displayPhotos(viewModel: PhotoGalleryModels.GetPhotos.ViewModel)
}

final class PhotoGalleryViewController: UIViewController, PhotoGalleryViewControllerInterface {
  
  static let storyboardId = String(describing: PhotoGalleryViewController.self)
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var interactor: PhotoGalleryInteractor!
  var router: PhotoGalleryRouter!
  var imageLibrary = ImageLibrary()
  
  fileprivate var state: PhotoState = .collection
  
  fileprivate var photoUrls: [URL] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    registerThumbnailCell()
    interactor.getPhotos(request: PhotoGalleryModels.GetPhotos.Request(state: state))
  }
  
  private func registerThumbnailCell() {
    let nib = UINib(nibName: ThumbnailImageCell.identifier, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: ThumbnailImageCell.identifier)
  }
  
  private func setupNavigationBar() {
    title = "My photos"
    let rightButton = UIBarButtonItem(image: getRightButtonImage(for: state), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(didTapSelectButton(_:)))
    navigationItem.rightBarButtonItem = rightButton
  }
  
  private func getRightButtonImage(for state: PhotoState) -> UIImage? {
    switch state {
    case .list:
      return UIImage(named: "gallery")
    case .collection:
      return UIImage(named: "picture")
    }
  }
  
  private func changeRightButtonImage(for state: PhotoState) {
    navigationItem.rightBarButtonItem?.image = getRightButtonImage(for: state)
  }


// MARK: Event handlers
@objc func didTapSelectButton(_ sender: UIBarButtonItem) {
  switch state {
  case .list:
    state = .collection
  case .collection:
    state = .list
  }
  changeRightButtonImage(for: state)
  collectionView.visibleCells.forEach {
    guard let cell = $0 as? ThumbnailImageCell else { return }
    cell.configure(with: nil)
  interactor.getPhotos(request: PhotoGalleryModels.GetPhotos.Request(state: state))
  }
}

fileprivate func configure() {
  let interactor = PhotoGalleryInteractor()
  let presenter = PhotoGalleryPresenter()
  let router = PhotoGalleryRouter()
  let photoWorker = PhotoRestWorker()
  
  interactor.presenter = presenter
  interactor.photoWorker = photoWorker
  
  presenter.viewController = self
  router.viewController = self
  
  self.interactor = interactor
  self.router = router
}

}
// MARK: Display Logic

extension PhotoGalleryViewController {
  
  func displayPhotos(viewModel: PhotoGalleryModels.GetPhotos.ViewModel) {
    hideLoader()
    switch viewModel.content {
    case .success(let data):
      photoUrls = data
    case .loading:
      showLoader()
    default:
      break
    }
  }
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoUrls.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailImageCell.identifier, for: indexPath) as? ThumbnailImageCell else { return UICollectionViewCell() }
    let row = indexPath.row
    let url = photoUrls[row]
    cell.id = row
    let resolution: ImageResolution = state == .list ? .res600 : .res150
    if let image = imageLibrary.image(with: resolution, for: row) {
      cell.configure(with: image)
    } else {
      cell.configure(with: nil)
      imageLibrary.fetchAsync(resolution, row, url) { image in
        DispatchQueue.main.async {
          guard cell.id == row else { return }
          cell.configure(with: image)
        }
      }
    }
    return cell
  }
  
}

extension PhotoGalleryViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    indexPaths.forEach {
      let row = $0.row
      let url = photoUrls[row]
      let resolution: ImageResolution = state == .list ? .res600 : .res150
      imageLibrary.fetchAsync(resolution, row, url)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    indexPaths.forEach {
      let row = $0.row
      let resolution: ImageResolution = state == .list ? .res600 : .res150
      imageLibrary.cancelFetch(resolution, row)
    }
  }
}

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width
    let threeColumnsWidth = width / 3 - 1
    return state == .list ? CGSize(width: width, height: width) : CGSize(width: threeColumnsWidth, height: threeColumnsWidth)
  }
}
