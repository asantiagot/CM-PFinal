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

class MapViewController: UIViewController, CLLocationManagerDelegate
{
    
    // MARK: ATTRIBUTES
    
    var mapParser = MapXMLParser()
    
    var distanceToStore = [Double]()
    var userLocation = [Double]()
    var storeLocation = [Double]()
    
    // MARK: OUTLETS
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDistance: UILabel!
    
    
    // MARK: CLLocationManager Attributes
    var locationManager: CLLocationManager!

    // MARK: ACTIONS
    
    @IBAction func navigateList(sender: UIButton) {
    }
    
    // MARK: METHODS
    
    
    // TODO
    func getLocation() -> [Double] {            // Return the exact location of the user ([0] = Latitude, [1] = Longitude)
        
        return userLocation
    }
    
    func startLocationServices() {

        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        
    }
    
    func calculateDistances() {     // Calculate the distance between the userLocation and the location of each store. RETURNS ARRAY TO USE AS LIST
        
    }
    
    override func viewDidLoad() {
        
        if mapParser.verifyValues() {
            for stores in mapParser.posts {
                print(stores)
            }
        }
            
        super.viewDidLoad()
        
        self.navigationItem.title = "Ubica tu Tienda"
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
