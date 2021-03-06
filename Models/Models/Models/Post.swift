//
//  Post.swift
//  Models
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct Post: Codable {
  public let userId: Int
  public let id: Int
  public let title: String
  public let body: String
  
  public init(userId: Int, id: Int, title: String, body: String) {
    self.userId = userId
    self.id = id
    self.title = title
    self.body = body
  }
}
