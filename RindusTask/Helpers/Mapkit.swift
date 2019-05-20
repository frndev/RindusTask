//
//  Mapkit.swift
//  RindusTask
//
//  Created by Francisco Navarro Aguilar on 15/5/19.
//  Copyright © 2019 Francisco Navarro Aguilar. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
  
  func moveTo(latitude lat: String, andLongitude lng: String) {
    guard let latitude = Double(lat), let longitude = Double(lng) else { return }
    let coordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate2D
    
    self.region = MKCoordinateRegion(center: coordinate2D, span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    self.addAnnotation(annotation)
    
  }
  
}
