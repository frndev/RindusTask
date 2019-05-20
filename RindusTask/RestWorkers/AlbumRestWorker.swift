//
//  AlbumRestWorker.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

private enum Endpoint: String {
  case albums = "https://jsonplaceholder.typicode.com/albums"
}

class AlbumRestWorker: AlbumWorkerProtocol {
  
  func getAlbums(userId: Int?, completion: @escaping ((JSONResult<ArrayData<Album>>) -> Void)) {
    var query: String?
    if let id = userId {
      query = "?userId=\(id)"
    }
    Rest.get(endPoint: Endpoint.albums.rawValue, query: query, type: ArrayData<Album>.self, completion: completion)
  }
  
  func createAlbum(postRequest: Album.PostRequest, completion: @escaping ((JSONResult<Album>) -> Void)) {
    let params = try? JSONEncoder().encode(postRequest)
    Rest.post(endPoint: Endpoint.albums.rawValue, params: params, type: Album.self, completion: completion)
  }
  
  func deleteAlbum(albumId: Int, completion: @escaping ((JSONResult<Nothing>) -> Void)) {
    Rest.delete(endPoint: Endpoint.albums.rawValue, id: albumId, completion: completion)
  }
  
  func editAlbum(albumId: Int, patchRequest: Album.PatchRequest, completion: @escaping ((JSONResult<Album>) -> Void)) {
    let params = try? JSONEncoder().encode(patchRequest)
    Rest.patch(endPoint: Endpoint.albums.rawValue, id: albumId, params: params, type: Album.self, completion: completion)
  }
  
}
