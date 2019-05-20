//
//  ProfileRouter.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

protocol ProfileRouterInterface {
  
  func presentWebView(with url: URL)
  func navigateToPhotoGallery()
  func navigateToPostsList()
  
}

class ProfileRouter: ProfileRouterInterface {
  weak var viewController: ProfileViewController?
  
  func presentWebView(with url: URL) {
    guard let navigationController = UIStoryboard(name: WebviewController.storyboardID, bundle: nil).instantiateInitialViewController() as? UINavigationController, let destinationViewController = navigationController.viewControllers.first as? WebviewController else {
      return
    }
    destinationViewController.url = url
    viewController?.present(navigationController, animated: true, completion: nil)
  }
  
  func navigateToPhotoGallery() {
    guard let destinationViewController = UIStoryboard(name: PhotoGalleryViewController.storyboardId, bundle: nil).instantiateInitialViewController() as? PhotoGalleryViewController else { return }
    destinationViewController.interactor.albumId = viewController?.interactor.selectedAlbum?.id
    viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
  }
  
  func navigateToPostsList() {
    guard let destinationViewController = UIStoryboard(name: PostsListViewController.storyboardID, bundle: nil).instantiateInitialViewController() as? PostsListViewController else { return }
    destinationViewController.interactor.userId = viewController?.interactor.user?.id
    viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
  }
  
}
