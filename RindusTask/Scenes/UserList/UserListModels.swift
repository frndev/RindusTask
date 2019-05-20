//
//  UserListModels.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

struct UserListModels {
  struct GetUsers {
    struct Request {}
    struct Response {
      let result: Result<ArrayData<User>>
    }
    struct ViewModel {
      let content: Content<[User]>
    }
  }
  
  struct SelectUser {
    struct Request {
      let user: User
    }
    struct Response {}
    struct ViewModel {}
  }
  
}
