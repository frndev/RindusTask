//
//  UserRestWorker.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 14/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

private enum Endpoint: String {
  case getUsers = "https://jsonplaceholder.typicode.com/users"
}

class UserRestWorker: UserWorkerProtocol {
  func getUsers(completion: @escaping ((JSONResult<ArrayData<User>>) -> Void)) {
    Rest.get(endPoint: Endpoint.getUsers.rawValue, type: ArrayData<User>.self, completion: completion)
  }
}


