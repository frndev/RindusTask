//
//  Photo.swift
//  Models
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct Photo: Codable {
  public let albumId: Int
  public let id: Int
  public let title: String
  public let url: String
  public let thumbnailUrl: String
  
  public init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
    self.albumId = albumId
    self.id = id
    self.title = title
    self.url = url
    self.thumbnailUrl = thumbnailUrl
  }
  
}
