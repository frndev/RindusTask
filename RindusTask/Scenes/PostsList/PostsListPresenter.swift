//
//  PostsListPresenter.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models
import Core

protocol PostsListPresenterInterface {
  func presentPosts(response: PostsListModels.GetPosts.Response)

}

class PostsListPresenter: PostsListPresenterInterface {
  var viewController: PostsListViewControllerInterface!
  
  func presentPosts(response: PostsListModels.GetPosts.Response) {
    let viewModel: PostsListModels.GetPosts.ViewModel
    switch response.result {
    case .loading:
      viewModel = PostsListModels.GetPosts.ViewModel(content: .loading)
    case .success(let data):
      viewModel = PostsListModels.GetPosts.ViewModel(content: .success(data: data.data))
    case .error(let error):
      viewModel = PostsListModels.GetPosts.ViewModel(content: .error(userError: error))
    }
    viewController.displayPosts(viewModel: viewModel)
  }
}
