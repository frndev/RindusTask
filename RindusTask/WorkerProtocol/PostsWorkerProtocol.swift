//
//  PostsWorkerProtocol.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

protocol PostsWorkerProtocol {
  func getPosts(userId: Int?, completion: @escaping ((JSONResult<ArrayData<Post>>) -> Void))
}
