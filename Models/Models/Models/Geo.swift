//
//  Geo.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 14/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct Geo: Codable {
  public let lat: String
  public let lng: String
  
  public init(lat: String, lng: String) {
    self.lat = lat
    self.lng = lng
  }
}

