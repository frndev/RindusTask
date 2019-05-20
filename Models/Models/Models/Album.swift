//
//  Album.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct Album: Codable {
  public let userId: Int
  public let id: Int
  public let title: String
  
  public struct PostRequest: Encodable {
    public let userId: Int
    public let title: String
    
    public init(userId: Int, title: String) {
      self.userId = userId
      self.title = title
    }
  }
  
  public struct PatchRequest: Encodable {
    public let title: String
    
    public init(title: String) {
      self.title = title
    }
  }
  
  public init(userId: Int, id: Int, title: String) {
    self.userId = userId
    self.id = id
    self.title = title
  }

}
