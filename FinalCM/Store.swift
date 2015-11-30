//
//  Store.swift
//  FinalCM
//
//  Created by Antonio Santiago on 11/30/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import Foundation
import MapKit

class Store: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let pinColor: UIColor
    
    init(name: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.location = location
        self.pinColor = MKPinAnnotationView.greenPinColor()
    }
    
    convenience init(name: String, latitude: Double, longitude: Double) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.init(name: name, location: location)
    }
    
    /*func pinColor() -> UIColor {
        return MKPinAnnotationView.greenPinColor()
    }
*/
}

@objc protocol Alertable {
    func alert() -> UIAlertController
}

extension Store: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(self.location.latitude), longitude: CLLocationDegrees(self.location.longitude))
    }
    
    var title: String? {
        return self.name
    }
}