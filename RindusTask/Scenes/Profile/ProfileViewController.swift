//
//  ProfileViewController.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Models
import MapKit
import Core

enum AlbumAction {
  case get
  case create
  case edit
  case delete
}

protocol ProfileViewControllerInterface {
  func displayUser(viewModel: ProfileModels.GetUser.ViewModel)
  func displayWebsite(viewModel: ProfileModels.GetWebsite.ViewModel)
  func displayAlbums(viewModel: ProfileModels.GetAlbums.ViewModel)
  func displaySelectedAlbum(viewModel: ProfileModels.SelectAlbum.ViewModel)
  func displayCreatedAlbum(viewModel: ProfileModels.CreateAlbum.ViewModel)
  func displayDeletedAlbum(viewModel: ProfileModels.DeleteAlbum.ViewModel)
  func displayEditedAlbum(viewModel: ProfileModels.EditAlbum.ViewModel)
}

final class ProfileViewController: UIViewController, ProfileViewControllerInterface {
  
  static let storyboardID = String(describing: ProfileViewController.self)
  var interactor: ProfileInteractor!
  var router: ProfileRouterInterface!
  var albumsDataSource: SimpleAlbumTableViewDataSource!
  var albumAction: AlbumAction?
  
  @IBOutlet weak var profileDataView: UIStackView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var itemLabel: UILabel!
  @IBOutlet weak var reloadButton: UIButton!
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var albumsTableView: ResizableTableView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    albumsDataSource = SimpleAlbumTableViewDataSource(tableView: albumsTableView)
    interactor.getUser(request: ProfileModels.GetUser.Request())
    albumAction = .get
  }
  
  private func setupNavigationBar() {
    let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ProfileViewController.didTapAddButton))
    navigationItem.rightBarButtonItem = rightButtonItem
  }
  
  // MARK: Event handlers
  
  @IBAction func didTapPostsButton() {
    router.navigateToPostsList()
  }
  
  @IBAction func didTapWebsiteButton() {
    interactor.getWebsite(request: ProfileModels.GetWebsite.Request())
  }
  
  @objc func didTapAddButton() {
    addAlbum()
  }
  
  @IBAction func didTapReloadButton(_ sender: UIButton) {
    reload()
  }
  
  private func addAlbum() {
    let alertController = UIAlertController.promptAlert(title: "Enter new album", message: "This will be your album´s name") { [weak self] textField in
      let title = textField.text
      self?.albumAction = .create
      self?.interactor.createAlbum(request: ProfileModels.CreateAlbum.Request(title: title))
    }
    present(alertController, animated: true, completion: nil)
  }
  
  // MARK: Display logic
  
  func displayUser(viewModel: ProfileModels.GetUser.ViewModel) {
      updateUI(with: viewModel.userData)
  }
  
  func displayWebsite(viewModel: ProfileModels.GetWebsite.ViewModel) {
    router.presentWebView(with: viewModel.url)
  }
  
  func displayAlbums(viewModel: ProfileModels.GetAlbums.ViewModel) {
    activityIndicatorView.isHidden = true
    switch viewModel.content {
    case .success(let data):
      albumsDataSource.setAlbums(data)
    case .loading:
      activityIndicatorView.isHidden = false
    case .error:
      reloadButton.isHidden = false
      showErrorAlert()
    default:
      break
    }
  }
  
  func displaySelectedAlbum(viewModel: ProfileModels.SelectAlbum.ViewModel) {
    router.navigateToPhotoGallery()
  }
  
  func displayCreatedAlbum(viewModel: ProfileModels.CreateAlbum.ViewModel) {
    activityIndicatorView.isHidden = true
    switch viewModel.content {
    case .success(let data):
      albumsDataSource.insert(data, at: 0)
    case .loading:
      activityIndicatorView.isHidden = false
    case .error:
      reloadButton.isHidden = false
      showErrorAlert()
    default:
      break
    }
  }
  
  func displayEditedAlbum(viewModel: ProfileModels.EditAlbum.ViewModel) {
    activityIndicatorView.isHidden = true
    switch viewModel.content {
    case .success(let data):
      albumsDataSource.update(data.album, at: data.row)
    case .loading:
      activityIndicatorView.isHidden = false
    case .error:
      showErrorAlert()
    default:
      break
    }
  }

  func displayDeletedAlbum(viewModel: ProfileModels.DeleteAlbum.ViewModel) {
    activityIndicatorView.isHidden = true
    switch viewModel.content {
    case .loading:
      activityIndicatorView.isHidden = false
    case .success(let data):
      albumsDataSource.remove(at: data)
    case .error:
      showErrorAlert()
    default:
      break
    }
  }
  
}

extension ProfileViewController {
  
  fileprivate func showLoading() {
    title = "Loading..."
    showLoader()
    profileDataView.isHidden = true
  }
  
  fileprivate func hideLoading() {
    hideLoader()
    profileDataView.isHidden = false
  }
  
  fileprivate func updateUI(with data: UserData) {
    title = data.username
    nameLabel.text = data.name
    descriptionLabel.text = data.description
    mapView.moveTo(latitude: data.lat, andLongitude: data.lng)
  }
  
}

extension ProfileViewController {
  fileprivate func configure() {
    let interactor = ProfileInteractor()
    let presenter = ProfilePresenter()
    let router = ProfileRouter()
    let albumWorker = AlbumRestWorker()
    
    interactor.presenter = presenter
    interactor.albumWorker = albumWorker
    
    presenter.viewController = self
    router.viewController = self
    
    self.interactor = interactor
    self.router = router
  }
  
  fileprivate func reload() {
    reloadButton.isHidden = true
    guard let action = albumAction else { return }
    switch action {
    case .get:
      interactor.getAlbums(request: ProfileModels.GetAlbums.Request())
    case .create:
      didTapAddButton()
    default:
      break
    }
  }
}

extension ProfileViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedRow = indexPath.row
    let album = albumsDataSource.albums[selectedRow]
    interactor.selectAlbum(request: ProfileModels.SelectAlbum.Request(album: album))
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let contextualAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, success) in
      let row = indexPath.row
      guard let album = self?.albumsDataSource.albums[row] else { return success(true) }
      self?.albumsTableView.isUserInteractionEnabled = false
      self?.interactor.deleteAlbum(request: ProfileModels.DeleteAlbum.Request(albumId: album.id, row: row) { isSuccess in
        self?.albumsTableView.isUserInteractionEnabled = true
        success(isSuccess)
      })
    }
    return UISwipeActionsConfiguration(actions: [contextualAction])
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let contextualAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, success) in
      let row = indexPath.row
      guard let album = self?.albumsDataSource.albums[row] else { return success(false) }
      
      let alertController = UIAlertController.promptAlert(title: "Enter new album's title", message: "This will be your album´s name") { [weak self] textField in
        let title = textField.text
        self?.albumsTableView.isUserInteractionEnabled = false
        self?.interactor.editAlbum(request: ProfileModels.EditAlbum.Request(albumId: album.id, title: title, row: row) { isSuccess in
            self?.albumsTableView.isUserInteractionEnabled = true
            success(isSuccess)
          })
      }
      self?.present(alertController, animated: true, completion: nil)
    }
    contextualAction.backgroundColor = .blue
    return UISwipeActionsConfiguration(actions: [contextualAction])
  }
}
