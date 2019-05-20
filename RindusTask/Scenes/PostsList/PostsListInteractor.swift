//
//  PostsListInteractor.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 19/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Models
import Core

protocol PostsListInteractorInterface {
  
  func getPosts(request: PostsListModels.GetPosts.Request)
  
  var userId: Int? { get set }
}

class PostsListInteractor: PostsListInteractorInterface {
  
  var presenter: PostsListPresenterInterface!
  var postWorker: PostsWorkerProtocol?
  
  var userId: Int?
  
  func getPosts(request: PostsListModels.GetPosts.Request) {
    presenter.presentPosts(response: PostsListModels.GetPosts.Response(result: .loading))
    postWorker?.getPosts(userId: userId) { [weak self] result in
      self?.presenter.presentPosts(response: PostsListModels.GetPosts.Response(result: result.result()))
    }
  }
  
}
