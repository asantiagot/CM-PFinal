//
//  MapViewController.swift
//  FinalCM
//
//  Created by Antonio Santiago on 10/27/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController
{
    var locationManager: CLLocationManager!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "Mapa"
        
        locationManager = CLLocationManager()
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
    }


}
