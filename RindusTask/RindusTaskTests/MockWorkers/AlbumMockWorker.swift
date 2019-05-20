//
//  AlbumMockWorker.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models
import Core
@testable import RindusTask
class AlbumMockStore: AlbumWorkerProtocol {
  func getAlbums(userId: Int?, completion: @escaping ((JSONResult<ArrayData<Album>>) -> Void)) {}
  
  func createAlbum(postRequest: Album.PostRequest, completion: @escaping ((JSONResult<Album>) -> Void)) {}
  
  func deleteAlbum(albumId: Int, completion: @escaping ((JSONResult<Nothing>) -> Void)) {}
  
  func editAlbum(albumId: Int, patchRequest: Album.PatchRequest, completion: @escaping ((JSONResult<Album>) -> Void)) {}
  
  

}
