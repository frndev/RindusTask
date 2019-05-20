//
//  UserListInteractor.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

protocol UserListInteractorInterface {
  func getUsers(request: UserListModels.GetUsers.Request)
  func setSelectedUser(request: UserListModels.SelectUser.Request)
  var selectedUser: User? { get set }

}

class UserListInteractor: UserListInteractorInterface {
  var presenter: UserListPresenterInterface!
  var userWorker: UserRestWorker?
  
  var selectedUser: User?
  
  func getUsers(request: UserListModels.GetUsers.Request) {
    presenter.presentUsers(response: UserListModels.GetUsers.Response(result: .loading))
    userWorker?.getUsers { [weak self] result in
      self?.presenter.presentUsers(response: UserListModels.GetUsers.Response(result: result.result()))
    }
  }
  
  func setSelectedUser(request: UserListModels.SelectUser.Request) {
    selectedUser = request.user
    presenter.presentSelectedUser(response: UserListModels.SelectUser.Response())
  }
  
}


