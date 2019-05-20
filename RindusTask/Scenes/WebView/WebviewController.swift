//
//  WebviewController.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import WebKit

final class WebviewController: UIViewController {
  
  static let storyboardID = String(describing: WebviewController.self)
  
  var url: URL?
  
  var defaultUrlRequest: URLRequest? {
    if let unwrappedURL = url {
      return URLRequest(url: unwrappedURL)
    } else {
      return nil
    }
  }
  
  @IBOutlet weak var webview: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webview.navigationDelegate = self
    setupCancelButton()
    if let webRequest = defaultUrlRequest {
      webview.load(webRequest)
    }
  }
  
  func setupCancelButton() {
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton(_:)))
    navigationItem.rightBarButtonItem = cancelButton
  }
  
  @objc func didTapCancelButton(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
}

extension WebviewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    title = "Loading content..."
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = nil
  }
}
