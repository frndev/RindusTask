//
//  ProfilePresenter.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models

protocol ProfilePresenterInterface {
  
  func presentUser(response: ProfileModels.GetUser.Response)
  func presentWebsite(response: ProfileModels.GetWebsite.Response)
  func presentAlbums(response: ProfileModels.GetAlbums.Response)
  func presentSelectedAlbum(response: ProfileModels.SelectAlbum.Response)
  func presentCreatedAlbum(response: ProfileModels.CreateAlbum.Response)
  func presentDeletedAlbum(response: ProfileModels.DeleteAlbum.Response)
  func presentEditedAlbum(response: ProfileModels.EditAlbum.Response)

}

class ProfilePresenter: ProfilePresenterInterface {
  var viewController: ProfileViewController!
  
  func presentUser(response: ProfileModels.GetUser.Response) {
    let userData = generateUserData(with: response.user)
    viewController.displayUser(viewModel: ProfileModels.GetUser.ViewModel(userData: userData))
      
  }
  
  func presentWebsite(response: ProfileModels.GetWebsite.Response) {
    guard let url = URL(string: "http://\(response.website)") else { return }
    viewController.displayWebsite(viewModel: ProfileModels.GetWebsite.ViewModel(url: url))
  }
  
  func presentAlbums(response: ProfileModels.GetAlbums.Response) {
    let viewModel: ProfileModels.GetAlbums.ViewModel
    switch response.result {
    case .loading:
      viewModel = ProfileModels.GetAlbums.ViewModel(content: .loading)
    case .success(let data):
      viewModel = ProfileModels.GetAlbums.ViewModel(content: .success(data: data))
    case .error(let error):
      viewModel = ProfileModels.GetAlbums.ViewModel(content: .error(userError: error))
    }
    viewController.displayAlbums(viewModel: viewModel)

  }
  
  func presentSelectedAlbum(response: ProfileModels.SelectAlbum.Response) {
    viewController.displaySelectedAlbum(viewModel: ProfileModels.SelectAlbum.ViewModel())
  }
  
  func presentCreatedAlbum(response: ProfileModels.CreateAlbum.Response) {
    let viewModel: ProfileModels.CreateAlbum.ViewModel
    switch response.result {
    case .success(let data):
      viewModel = ProfileModels.CreateAlbum.ViewModel(content: .success(data: data))
    case .loading:
      viewModel = ProfileModels.CreateAlbum.ViewModel(content: .loading)
    case .error(let error):
      viewModel = ProfileModels.CreateAlbum.ViewModel(content: .error(userError: error))
    }
    viewController.displayCreatedAlbum(viewModel: viewModel)
  }
  
  func presentEditedAlbum(response: ProfileModels.EditAlbum.Response) {
    let viewModel: ProfileModels.EditAlbum.ViewModel
    switch response.result {
    case .success(let data):
      viewModel = ProfileModels.EditAlbum.ViewModel(content: .success(data: data))
    case .loading:
      viewModel = ProfileModels.EditAlbum.ViewModel(content: .loading)
    case .error(let error):
      viewModel = ProfileModels.EditAlbum.ViewModel(content: .error(userError: error))
    }
    viewController.displayEditedAlbum(viewModel: viewModel)
  }
  
  func presentDeletedAlbum(response: ProfileModels.DeleteAlbum.Response) {
    let viewModel: ProfileModels.DeleteAlbum.ViewModel
    switch response.result {
    case .success(let data):
      viewModel = ProfileModels.DeleteAlbum.ViewModel(content: .success(data: data))
    case .loading:
      viewModel = ProfileModels.DeleteAlbum.ViewModel(content: .loading)
    case .error(let error):
      viewModel = ProfileModels.DeleteAlbum.ViewModel(content: .error(userError: error))
    }
    viewController.displayDeletedAlbum(viewModel: viewModel)
  }
  
}

extension ProfilePresenter {
  fileprivate func generateUserData(with data: User) -> UserData {
    let description = "Working for \(data.company.name) in \(data.company.catchPhrase)"
    return UserData(name: data.name, username: data.username, email: data.email, website: data.website, lat: data.address.geo.lat, lng: data.address.geo.lng, description: description)
  }
}
