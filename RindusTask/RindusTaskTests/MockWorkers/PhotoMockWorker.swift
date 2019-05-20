//
//  PhotoMockWorker.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models
@testable import RindusTask
class PhotoMockWorker: PhotoWorkerProtocol {
  func getPhotos(albumId: Int?, completion: @escaping ((JSONResult<ArrayData<Photo>>) -> Void)) {
    
  }
}
