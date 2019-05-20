//
//  PostsListModels.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models
import Core

struct PostsListModels {
  struct GetPosts {
    struct Request {}
    struct Response {
      let result: Result<ArrayData<Post>>
    }
    struct ViewModel {
      let content: Content<[Post]>
    }
  }
}
