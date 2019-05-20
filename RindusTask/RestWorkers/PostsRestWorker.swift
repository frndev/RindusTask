//
//  PostsRestWorker.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

private enum Endpoint: String {
  case posts = "https://jsonplaceholder.typicode.com/posts"
}

class PostsRestWorker: PostsWorkerProtocol {
  func getPosts(userId: Int?, completion: @escaping ((JSONResult<ArrayData<Post>>) -> Void)) {
    var query: String?
    if let id = userId {
      query = "?userId=\(id)"
    }
    Rest.get(endPoint: Endpoint.posts.rawValue, query: query, type: ArrayData<Post>.self, completion: completion)
  }
}
