//
//  SimpleAlbumTableViewDataSource.swift
//  RindusTaskTests
//
//  Created by Francisco Navarro Aguilar on 18/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Models

class SimpleAlbumTableViewDataSource: NSObject, UITableViewDataSource {
  
  weak var albumsTableView: UITableView?
  
  init(tableView: UITableView) {
    super.init()
    albumsTableView = tableView
    tableView.dataSource = self
  }
  
  var albums: [Album] = []
  
  func setAlbums(_ albums: [Album]) {
    self.albums = albums
    albumsTableView?.reloadData()
  }
  
  func insert(_ album: Album, at index: Int) {
    albums.insert(album, at: index)
    albumsTableView?.beginUpdates()
    albumsTableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .left)
    albumsTableView?.endUpdates()
  }
  
  func update(_ album: Album, at index: Int) {
    albums[index] = album
    albumsTableView?.beginUpdates()
    albumsTableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    albumsTableView?.endUpdates()
  }
  
  func remove(at index: Int) {
    albums.remove(at: index)
    albumsTableView?.beginUpdates()
    albumsTableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
    albumsTableView?.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let identifier = String(describing:UITableViewCell.self)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
      let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
      configureCell(cell, forRowAt: indexPath)
      return cell
    }
    
    configureCell(cell, forRowAt: indexPath)
    return cell
  }
  
  fileprivate func configureCell(_ cell: UITableViewCell?, forRowAt indexPath: IndexPath) {
    let row = indexPath.row
    let album = albums[row]
    cell?.textLabel?.numberOfLines = 0
    cell?.textLabel?.text = album.title
  }
  
}
