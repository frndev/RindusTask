//
//  UserListTableViewCell.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

protocol UserListTableViewCellDelegate: class {
  func didTapEmailButton(in cell: UserListTableViewCell)
}

class UserListTableViewCell: UITableViewCell {
  
  static let identifier = String(describing: UserListTableViewCell.self)
  
  weak var delegate: UserListTableViewCellDelegate?
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBAction func didTapEmailButton(_ sender: UIButton) {
    delegate?.didTapEmailButton(in: self)
  }
  
  func updateUI(text: String, description: String) {
    titleLabel.text = text
    descriptionLabel.text = description
  }
  
}
