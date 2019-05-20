//
//  PhotoGalleryInteractor.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

protocol PhotoGalleryInteractorInterface {
  func getPhotos(request: PhotoGalleryModels.GetPhotos.Request)
  
  var albumId: Int? { get set }
  var photos: ArrayData<Photo>? { get set }
  
}

class PhotoGalleryInteractor: PhotoGalleryInteractorInterface {
  var presenter: PhotoGalleryPresenter!
  var photoWorker: PhotoWorkerProtocol?
  var imageLibrary = ImageLibrary()
  
  var albumId: Int?
  var photos: ArrayData<Photo>?
  
  func getPhotos(request: PhotoGalleryModels.GetPhotos.Request) {
    if let photos = photos {
      let photoViewData = PhotoGalleryModels.GetPhotos.PhotoViewData(photos: photos, state: request.state)
      let response = PhotoGalleryModels.GetPhotos.Response(result: .success(data: photoViewData))
      presenter.presentPhotos(response: response)
      return
    }
    var response = PhotoGalleryModels.GetPhotos.Response(result: .loading)
    presenter.presentPhotos(response: response)
    photoWorker?.getPhotos(albumId: albumId) { [weak self] result in
      switch result {
      case .success(let data):
        self?.photos = data
        let photoViewData = PhotoGalleryModels.GetPhotos.PhotoViewData(photos: data, state: request.state)
      response = PhotoGalleryModels.GetPhotos.Response(result: .success(data: photoViewData))
      case .error(let error):
        response = PhotoGalleryModels.GetPhotos.Response(result: .error(userError: error))
      }
      self?.presenter.presentPhotos(response: response)
    }
  }
  
}
