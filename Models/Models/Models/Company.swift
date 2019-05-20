//
//  Company.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 14/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct Company: Codable {
  public let name: String
  public let catchPhrase: String
  public let bs: String
  
  public init(name: String, catchPhrase: String, bs: String) {
    self.name = name
    self.catchPhrase = catchPhrase
    self.bs = bs
  }
}
