//
//  ProfileInteractorTests.swift
//  RindusTaskTestsTests
//
//  Created by Francisco Navarro Aguilar on 18/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import XCTest
import Core
import Models
@testable import RindusTask

class ProfileInteractorTests: XCTestCase {
  
  var sut: ProfileInteractor!
  var interactorOutputSpy: ProfilePresenterOutputSpy!
  override func setUp() {
    sut = ProfileInteractor()
    interactorOutputSpy = ProfilePresenterOutputSpy()
    sut.presenter = interactorOutputSpy
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  class ProfilePresenterOutputSpy: ProfilePresenterInterface {
    
    var presentUserCalled = false
    var presentWebsiteCalled = false
    var presentAlbumsCalled = false
    var presentEditedAlbumCalled = false
    var presentSelectedAlbumCalled = false
    var presentCreatedAlbumCalled = false
    var presentDeletedAlbumCalled = false
    
    func presentUser(response: ProfileModels.GetUser.Response) {
      presentUserCalled = true
    }
    
    func presentWebsite(response: ProfileModels.GetWebsite.Response) {
      presentWebsiteCalled = true
    }
    
    func presentAlbums(response: ProfileModels.GetAlbums.Response) {
      presentAlbumsCalled = true
    }
    func presentEditedAlbum(response: ProfileModels.EditAlbum.Response) {
      presentEditedAlbumCalled = true
    }
    func presentSelectedAlbum(response: ProfileModels.SelectAlbum.Response) {
      presentSelectedAlbumCalled = true
    }
    
    func presentCreatedAlbum(response: ProfileModels.CreateAlbum.Response) {
      presentCreatedAlbumCalled = true
    }
    
    func presentDeletedAlbum(response: ProfileModels.DeleteAlbum.Response) {
      presentDeletedAlbumCalled = true
    }
  }
  
  func testGetProfileErroredShouldCallPresenterToPresentProfile() {
    // Given
    setUp()
    let user = User(id: 0, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
    sut.user = user
    // When
    sut.getUser(request: ProfileModels.GetUser.Request())
    // Then
    XCTAssert(interactorOutputSpy.presentUserCalled, "getProfile with error should call presenter to presentUser")
  }
  
}
