//
//  ImageLibrary.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

func == (lhs: ImageResolution, rhs: ImageResolution) -> Bool {
  return lhs.rawValue == rhs.rawValue
}

enum ImageResolution: String {
  case res150 = "res150"
  case res600 = "res600"
  
  var hashValue: Int {
    return self.rawValue.hashValue
  }
}

class ImageLibrary {
  
  fileprivate let serialAccessQueue = OperationQueue()
  fileprivate let fetchQueue = OperationQueue()
  fileprivate var completionHandlers: [ImageResolution: [Int: (UIImage?) -> Void]] = [:]
  
  fileprivate var images: [ImageResolution: [Int: UIImage?]] = [:]
  
  init() {
    serialAccessQueue.maxConcurrentOperationCount = 1
    images[.res150] = [:]
    images[.res600] = [:]
    completionHandlers[.res150] = [:]
    completionHandlers[.res600] = [:]
  }
  
  func fetchAsync(_ resolution: ImageResolution, _ row: Int, _ url: URL, completion: ((UIImage?) -> Void)? = nil) {
    fetchQueue.addOperation {
      if let completion = completion {
        self.completionHandlers[resolution]?[row] = completion
      }
      
      self.getImage(with: resolution, for: row, with: url)
    }
  }
  
  func image(with resolution: ImageResolution, for row: Int) -> UIImage? {
    return images[resolution]?[row].flatMap {
      return $0
    }
  }
  
  func cancelFetch(_ resolution: ImageResolution, _ row: Int) {
    serialAccessQueue.addOperation {
      self.fetchQueue.isSuspended = true
      defer {
        self.fetchQueue.isSuspended = false
      }
      
      self.operation(with: resolution, for: row)?.cancel()
      self.completionHandlers[resolution]?[row] = nil
    }
  }
  
  private func operation(with resolution: ImageResolution, for row: Int) -> ImageOperation? {
    for case let fetchOperation as ImageOperation in fetchQueue.operations
      where !fetchOperation.isCancelled && fetchOperation.row == row &&
        fetchOperation.resolution == resolution {
        return fetchOperation
    }
    
    return nil
  }
  
  private func getImage(with resolution: ImageResolution, for row: Int, with url: URL) {
    guard operation(with: resolution, for: row) == nil else { return }
    
    if let image = images[resolution]?[row] {
      callCompletionHandler(with: resolution, for: row, with: image)
    } else {
      let operation = ImageOperation(resolution: resolution, row: row, url: url)
      
      operation.completionBlock = { [weak operation] in
        guard let image = operation?.image else { return }
          self.images[resolution]?[row] = image
        
        self.serialAccessQueue.addOperation {
          self.callCompletionHandler(with: resolution, for: row, with: image)
        }
      }
      
      fetchQueue.addOperation(operation)
    }
  }
  
  private func callCompletionHandler(with resolution: ImageResolution, for row: Int, with image: UIImage?) {
    let completionHandler = self.completionHandlers[resolution]?[row]
    self.completionHandlers[resolution]?[row] = nil
      completionHandler?(image)
  }
  
}
