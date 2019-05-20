//
//  System.swift
//  Core
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

public struct System {
  public static func send(_ email: String) {
    guard let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
