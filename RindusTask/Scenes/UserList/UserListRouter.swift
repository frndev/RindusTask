//
//  UserListRouter.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

protocol UserListRouterInterface {
  func navigateToProfile()
}

class UserListRouter: UserListRouterInterface {
  weak var viewController: UserListViewController!
  
  func navigateToProfile() {
    guard let destination = UIStoryboard(name: ProfileViewController.storyboardID, bundle: nil).instantiateInitialViewController() as? ProfileViewController else { return }
    destination.interactor.user = viewController.interactor.selectedUser
    viewController.navigationController?.pushViewController(destination, animated: true)
  }
}
