//
//  PhotoRestWorker.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

fileprivate enum Endpoint: String {
  case getPhotos = "https://jsonplaceholder.typicode.com/photos"
}

class PhotoRestWorker: PhotoWorkerProtocol {
  
  func getPhotos(albumId: Int?, completion: @escaping ((JSONResult<ArrayData<Photo>>) -> Void)) {
    var query: String?
    if let id = albumId {
      query = "?albumId=\(id)"
    }
    Rest.get(endPoint: Endpoint.getPhotos.rawValue, query: query, type: ArrayData<Photo>.self, completion: completion)
  }
  
}
