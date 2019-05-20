//
//  ArrayData.swift
//  Models
//
//  Created by Francisco Navarro Aguilar on 20/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation

public struct ArrayData<T: Codable>: Codable {
  public let data: [T]
  
  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()
    
    var elements = [T]()
    if let count = container.count {
      elements.reserveCapacity(count)
    }
    
    while !container.isAtEnd {
      if let element = try? container.decode(T.self) {
        elements.append(element)
      }
    }
    
    data = elements
  }
}
