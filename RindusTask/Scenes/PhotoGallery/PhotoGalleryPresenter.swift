//
//  PhotoGalleryPresenter.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

protocol PhotoGalleryPresenterInterface {
  func presentPhotos(response: PhotoGalleryModels.GetPhotos.Response)
}

class PhotoGalleryPresenter: PhotoGalleryPresenterInterface {
  var viewController: PhotoGalleryViewController!
  
  func presentPhotos(response: PhotoGalleryModels.GetPhotos.Response) {
    switch response.result {
    case .success(let data):
      let urls = generateThumbnailUrls(with: data.photos, and: data.state)
      let viewModel = PhotoGalleryModels.GetPhotos.ViewModel(content: .success(data: urls))
      viewController.displayPhotos(viewModel: viewModel)
    case .loading:
      viewController.displayPhotos(viewModel: PhotoGalleryModels.GetPhotos.ViewModel(content: .loading))
    case .error(let error):
      viewController.displayPhotos(viewModel: PhotoGalleryModels.GetPhotos.ViewModel(content: .error(userError: error)))
      break
    }
  }
  
}

extension PhotoGalleryPresenter {
  fileprivate func generateThumbnailUrls(with photos: ArrayData<Photo>, and state: PhotoState) -> [URL] {
    return photos.data.compactMap {
      let url = state == .list ? $0.url : $0.thumbnailUrl
      return URL(string: url)
    }
  }
}
