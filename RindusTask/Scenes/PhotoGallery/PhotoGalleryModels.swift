//
//  PhotoGalleryModels.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

struct PhotoGalleryModels {
  
  struct GetPhotos {
    struct Request {
      let state: PhotoState
    }
    struct Response {
      let result: Result<PhotoViewData>
    }
    struct ViewModel {
      let content: Content<[URL]>
    }
    struct PhotoViewData {
      let photos: ArrayData<Photo>
      let state: PhotoState
    }
  }
  
  struct GetPhoto {
    struct Request {
      let cell: ThumbnailImageCell
      let row: Int
      let indexPath: IndexPath
      let url: URL
      let completion: ((UIImage?) -> Void)?
    }
    struct Response {
      let cell: ThumbnailImageCell
      let row: Int
      let image: UIImage?
    }
    struct ViewModel {
      let cell: ThumbnailImageCell
      let row: Int
      let image: UIImage?
    }
  }
  
  struct FetchAsync {
    struct Request {
      let row: Int
      let url: URL
    }
  }
  
  struct CancelAsync {
    struct Request {
      let row: Int
    }
  }
  
}
