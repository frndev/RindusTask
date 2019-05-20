//
//  ProfileInteractor.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models

protocol ProfileInteractorInterface {
  func getUser(request: ProfileModels.GetUser.Request)
  func getWebsite(request: ProfileModels.GetWebsite.Request)
  func getAlbums(request: ProfileModels.GetAlbums.Request)
  func createAlbum(request: ProfileModels.CreateAlbum.Request)
  func editAlbum(request: ProfileModels.EditAlbum.Request)
  func selectAlbum(request: ProfileModels.SelectAlbum.Request)
  func deleteAlbum(request: ProfileModels.DeleteAlbum.Request)
  
  var user: User? { get set }
  var selectedAlbum: Album? { get set }
}


class ProfileInteractor: ProfileInteractorInterface {
  var presenter: ProfilePresenterInterface!

  var albumWorker: AlbumWorkerProtocol?
  
  var user: User?
  var selectedAlbum: Album?
  var albums: [Album] = []
  
  func getUser(request: ProfileModels.GetUser.Request) {
    guard let user = user else {
      return // TODO : error
    }
    getAlbums(request: ProfileModels.GetAlbums.Request())
    presenter.presentUser(response: ProfileModels.GetUser.Response(user: user))
    
  }
  
  func getWebsite(request: ProfileModels.GetWebsite.Request) {
    guard let website = user?.website else { return }
    presenter.presentWebsite(response: ProfileModels.GetWebsite.Response(website: website))
  }
  
  func getAlbums(request: ProfileModels.GetAlbums.Request) {
    var response = ProfileModels.GetAlbums.Response(result: .loading)
    presenter.presentAlbums(response: response)

    albumWorker?.getAlbums(userId: user?.id) { [weak self] result in
      switch result {
      case .success(let data):
        let sortedAlbums = data.data.sorted(by: {
          $0.id > $1.id
        })
        self?.albums = sortedAlbums
        response = ProfileModels.GetAlbums.Response(result: .success(data: sortedAlbums))
      case .error(let error):
        response = ProfileModels.GetAlbums.Response(result: .error(userError: error))
      }
      self?.presenter.presentAlbums(response: response)
    }
  }
  
  func selectAlbum(request: ProfileModels.SelectAlbum.Request) {
    selectedAlbum = request.album
    presenter.presentSelectedAlbum(response: ProfileModels.SelectAlbum.Response())
  }
  
  func createAlbum(request: ProfileModels.CreateAlbum.Request) {
    typealias Response = ProfileModels.CreateAlbum.Response
    guard let userId = user?.id, let title = request.title else {
      let response = Response(result: .error(userError: .internalError))
      presenter.presentCreatedAlbum(response: response)
      return
    }
    var response = Response(result: .loading)
    presenter.presentCreatedAlbum(response: response)
    let request = Album.PostRequest(userId: userId, title: title)
    albumWorker?.createAlbum(postRequest: request) { [weak self] result in
      switch result {
      case .success(let data):
        response = Response(result: .success(data: data))
      case .error(let error):
        response = Response(result: .error(userError: error))
      }
      self?.presenter.presentCreatedAlbum(response: response)
    }
  }
  
  func editAlbum(request: ProfileModels.EditAlbum.Request) {
    guard let title = request.title else { return }
    var response = ProfileModels.EditAlbum.Response(result: .loading)
    presenter.presentEditedAlbum(response: response)
    let patchRequest = Album.PatchRequest(title: title)
    albumWorker?.editAlbum(albumId: request.albumId, patchRequest: patchRequest) { [weak self] result in
      switch result {
      case .success(let data):
        response = ProfileModels.EditAlbum.Response(result: .success(data: ProfileModels.EditAlbum.EditData(album: data, row: request.row)))
        request.completion(true)
      case .error(let error):
        response = ProfileModels.EditAlbum.Response(result: .error(userError: error))
        request.completion(false)
      }
      self?.presenter.presentEditedAlbum(response: response)
    }
  }

  
  func deleteAlbum(request: ProfileModels.DeleteAlbum.Request) {
    var response = ProfileModels.DeleteAlbum.Response(result: .loading)
    presenter.presentDeletedAlbum(response: response)
    albumWorker?.deleteAlbum(albumId: request.albumId) { [weak self] result in
      switch result {
      case .success:
        response = ProfileModels.DeleteAlbum.Response(result: .success(data: request.row))
        request.completion(true)
      case .error(let error):
        response = ProfileModels.DeleteAlbum.Response(result: .error(userError: error))
        request.completion(false)
      }
      self?.presenter.presentDeletedAlbum(response: response)
    }
  }
  
}
