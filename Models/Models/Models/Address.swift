//
//  Address.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 14/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct Address: Codable {
  public let street: String
  public let suite: String
  public let city: String
  public let zipcode: String
  public let geo: Geo
  
  public init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
    self.street = street
    self.suite = suite
    self.city = city
    self.zipcode = zipcode
    self.geo = geo
  }
  
}
