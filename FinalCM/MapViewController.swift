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
    
    var storesInfo = [[String: String]]()
    var distancesToStores = [CLLocationDistance]()
    var storesLocation = [CLLocationCoordinate2D]()
    var userLocation = CLLocationCoordinate2D()
    
    // MARK: OUTLETS
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDistance: UILabel!
    
    
    // MARK: CLLocationManager Attributes
    var locationManager: CLLocationManager!

    // MARK: ACTIONS
    
    @IBAction func navigateList(sender: UIButton) {
    }
    
    // MARK: METHODS
    
    func startLocationServices() {

        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
    }
    
    func calculateDistances() {     // Calculate the distance between the userLocation and the location of each store. RETURNS ARRAY TO USE AS LIST
        var counter = 0
        var currentStoreLocation: CLLocation
        var element = [String:String]()
        
        /*
        Description of this for cycle
        1. Store Latitude and Longitude from storesInfo in temporal variables
        2. Use latitude and longitude to conform CLLocation
        3. Calculate distance between user location and store location
        4. Append this distance to distanceToStores (this step could be deleted if no longer used)
        5. Add this distance as a new key for the storesInfo Dictionary
        */
        for stores in storesInfo {
            print("About to read data from \(stores)")
            let currentLat = Double(stores["LATITUDE"]!)
            let currentLon = Double(stores["LONGITUDE"]!)
            currentStoreLocation = CLLocation(latitude: currentLat!, longitude: currentLon!)
            print("User location is:\nLatitude: \(userLocation.latitude)\nLongitude: \(userLocation.longitude)")
            let distanceToStore = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude).distanceFromLocation(currentStoreLocation)
            distancesToStores.append(distanceToStore)
            element["DISTTOUSER"] = String(distanceToStore)
            
            // TODO: FIND OUT HOW TO APPEND ONLY THE DISTANCE TO USER FOR EVERY ELEMENT IN STORES. THIS SHOULD NOT OVERWRITE THE WHOLE DICTIONARY
            storesInfo[counter]["DISTTOUSER"] = String(distanceToStore)
            print("Current state of stores is:\n \(stores)")

            // storesInfo.append(element)
            print("Distance to store number \(counter) is \(distancesToStores[counter])")
            counter++
        }
        
        print("Final value of storesInfo is:\n")
        for stores in storesInfo {
            print(stores)
        }
    }
    
    override func viewDidLoad() {
        
        if mapParser.verifyValues() {
            print("Copiando valores desde XMLParser")
            for stores in mapParser.posts {
                storesInfo.append(stores)
            }
            print("Valores de storesInfo son: ")
            for values in storesInfo {
                print(values)
            }
            startLocationServices()
            // calculateDistances()
        } else {
            let noConnectionController = UIAlertController(title: "Conexión no establecida", message: "El servidor no está disponible o no tienes acceso a Internet. Intenta más tarde.", preferredStyle: UIAlertControllerStyle.Alert)
            noConnectionController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction: UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(noConnectionController, animated: true, completion: nil)
        }
            
        super.viewDidLoad()
        
        self.navigationItem.title = "Ubica tu Tienda"
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // CLLocationManagerDelegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locationManager.location!.coordinate
        print("locations = \(userLocation.latitude) \(userLocation.longitude)")
        
        calculateDistances()
    }
}
