//
//  ImageOperation.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import UIKit

class ImageOperation: Operation {
  
  let resolution: ImageResolution
  let url: URL
  let row: Int
  
  private(set) var image: UIImage?
  
  init(resolution: ImageResolution, row: Int, url: URL) {
    self.resolution = resolution
    self.row = row
    self.url = url
  }
  
  func getImage() {
    do {
      let data = try Data(contentsOf: url)
      image = UIImage(data: data)
    } catch {
      print("Error fetching")
    }
    
  }
  
  override func main() {
    getImage()
  }
  
}
