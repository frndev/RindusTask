//
//  Loader.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 18/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class LoaderView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addActivityIndicatorView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addActivityIndicatorView()
  }
  
  func addActivityIndicatorView() {
    let indicatorView = UIActivityIndicatorView(style: .white)
    indicatorView.startAnimating()
    indicatorView.color = .gray
    indicatorView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(indicatorView)
    
    let horizontalContraint = NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let topConstraint = NSLayoutConstraint(item: indicatorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 200)
    
    self.addConstraint(horizontalContraint)
    self.addConstraint(topConstraint)
  }
  
}

extension UIViewController {
  
  func showLoader() {
    let loaderView = LoaderView(frame: view.frame)
    view.addSubview(loaderView)
    view.bringSubviewToFront(loaderView)
    
  }
  
  func hideLoader() {
    view.subviews.forEach {
      if $0 is LoaderView {
        $0.removeFromSuperview()
      }
    }
  }
  
}
