//
//  ResizableTableView.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 16/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class ResizableTableView: UITableView {
  
  override func reloadData() {
    super.reloadData()
    invalidateIntrinsicContentSize()
    layoutIfNeeded()
  }
  
  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 16)
  }
}
