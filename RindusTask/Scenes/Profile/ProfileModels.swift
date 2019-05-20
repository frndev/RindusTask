//
//  ProfileModels.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import Core
import Models

typealias UserData = ProfileModels.GetUser.ViewModel.UserData

struct ProfileModels {
  struct GetUser {
    struct Request {}
    
    struct Response {
      let user: User
    }

    struct ViewModel {
      let userData: UserData
      
      struct UserData {
        let name: String
        let username: String
        let email: String
        let website: String
        let lat: String
        let lng: String
        let description: String
      }
    }
  }
  
  struct GetWebsite {
    struct Request{}
    struct Response {
      let website: String
    }
    struct ViewModel {
      let url: URL
    }
  }
  
  struct GetAlbums {
    struct Request{}
    struct Response {
      let result: Result<[Album]>
    }
    struct ViewModel {
      let content: Content<[Album]>
    }
  }
  
  struct SelectAlbum {
    struct Request {
      let album: Album
    }
    struct Response {}
    struct ViewModel {}
  }
  
  struct CreateAlbum {
    struct Request {
      let title: String?
    }
    struct Response {
      let result: Result<Album>
    }
    
    struct ViewModel {
      let content: Content<Album>
    }
  }
  
  struct EditAlbum {
    struct Request {
      let albumId: Int
      let title: String?
      let row: Int
      let completion: (Bool) -> Void
    }
    struct Response {
      let result: Result<EditData>
      
    }
    
    struct ViewModel {
      let content: Content<EditData>
    }
    
    struct EditData {
      let album: Album
      let row: Int
    }
  }
  
  struct DeleteAlbum {
    struct Request {
      let albumId: Int
      let row: Int
      let completion: (Bool) -> Void
    }
    struct Response {
      let result: Result<Int>
    }
    
    struct ViewModel {
      let content: Content<Int>
    }
  }
  
}

