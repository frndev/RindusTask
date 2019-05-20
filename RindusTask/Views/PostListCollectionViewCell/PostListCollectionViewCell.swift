//
//  PostListCollectionViewCell.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 20/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

struct PostListCollectionViewCellData {
  let title: String
  let description: String
}

class PostListCollectionViewCell: UICollectionViewCell {

  static let identifier = String(describing: PostListCollectionViewCell.self)
  
  lazy var width: NSLayoutConstraint = {
    let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
    width.isActive = true
    return width
  }()
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    contentView.translatesAutoresizingMaskIntoConstraints = false

    if let lastSubview = contentView.subviews.last {
      contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
   
    self.layer.backgroundColor = UIColor.white.cgColor
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.3
    self.layer.masksToBounds = false

  }
  
  func configure(with data: PostListCollectionViewCellData) {
    titleLabel.text = data.title
    descriptionLabel.text = data.description
  }

  override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    width.constant = bounds.size.width
    return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 100))
  }
}
