//
//  ThumbnailImageCell.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class ThumbnailImageCell: UICollectionViewCell {
  
  var image: UIImage? {
    get {
      return imageView.image
    }
    
    set {
      imageView.image = newValue
    }
    
  }
  
  static let identifier = String(describing: ThumbnailImageCell.self)
  
  var id: Int!
  
  @IBOutlet weak var imageView: UIImageView!
  
  func configure(with image: UIImage?) {
    guard let image = image else {
      self.image = UIImage(named: "Camera")
      return
    }
    imageView.alpha = 0.5
    imageView.image = image
    UIView.animate(withDuration: 0.25) { [weak imageView] in
      
      imageView?.alpha = 1
    }
    
  }
  
}
