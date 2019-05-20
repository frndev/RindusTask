//
//  UserListPresenter.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models
import Core

protocol UserListPresenterInterface {
  func presentUsers(response: UserListModels.GetUsers.Response)
  func presentSelectedUser(response: UserListModels.SelectUser.Response)
}

class UserListPresenter: UserListPresenterInterface {
  var viewController: UserListViewControllerInterface!
  
  func presentUsers(response: UserListModels.GetUsers.Response) {
    switch response.result {
    case .loading:
      viewController.displayUsers(viewModel: UserListModels.GetUsers.ViewModel(content: .loading))
    case .success(let data):
      viewController.displayUsers(viewModel: UserListModels.GetUsers.ViewModel(content: .success(data: data.data)))
    case .error(let error):
      viewController.displayUsers(viewModel: UserListModels.GetUsers.ViewModel(content: .error(userError: error)))
    
    }
  }
  
  func presentSelectedUser(response: UserListModels.SelectUser.Response) {
    viewController.displaySelectedUser(viewModel: UserListModels.SelectUser.ViewModel())
  }
}

extension UserListPresenter {
  
}
