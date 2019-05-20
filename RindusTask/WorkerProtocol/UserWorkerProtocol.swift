//
//  UserWorkerProtocol.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

protocol UserWorkerProtocol {
  func getUsers(completion: @escaping ((JSONResult<ArrayData<User>>) -> Void))
}
