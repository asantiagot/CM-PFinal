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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: ATTRIBUTES
    
    var mapParser = MapXMLParser()
    var pointAnnotation = MKPointAnnotation()
    var MKPin = MKPinAnnotationView()
    
    var mkAnnotationStores: [Store] = []
    
    var displayIndex = 0
    
    var storesInfo = [[String: String]]()
    var distancesToStores = [CLLocationDistance]()
    var storesLocation = [CLLocationCoordinate2D]()
    var userLocation = CLLocationCoordinate2D()
    
    // MARK: OUTLETS
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDistance: UILabel!
    
    @IBOutlet weak var mkMapView: MKMapView!
    
    // MARK: CLLocationManager Attributes
    var locationManager: CLLocationManager!

    // MARK: ACTIONS
    
    @IBAction func navigateList(sender: UIButton) {
        if sender.tag == 0 {        // LEFT
            if displayIndex == 0 {
                displayIndex = storesInfo.count-1
            } else {
                displayIndex--
            }
        } else {                    // RIGHT
            if displayIndex == storesInfo.count-1 {
                displayIndex = 0
            } else {
                displayIndex++
            }
        }
        displayStoresInView(displayIndex)
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
            
            storesInfo[counter]["DISTTOUSER"] = String(distanceToStore)
            print("Current state of stores is:\n \(stores)")

            // storesInfo.append(element)
            print("Distance to store number \(counter) is \(distancesToStores[counter])")
            counter++
        }
        
        // Sorting storesInfo according to distance from store to user location (bubble sort)
        
        var swaps = true
        while (swaps) {
            swaps = false
            for var i=0; i<storesInfo.count; i++ {
                if !(i+1 == storesInfo.count) {                                             // Making sure Dictionary index is valid
                    print("Will work with index \(i)")
                    if(storesInfo[i+1]["DISTTOUSER"] < storesInfo[i]["DISTTOUSER"]) {       // If the next value is greater...
                        print(" Value of DISTTOUSER at i+1 is \(storesInfo[i+1]["DISTTOUSER"]) and same key at current index is \(storesInfo[i]["DISTTOUSER"])")
                        let auxVar = storesInfo[i]                                          // Store current value in auxiliary variable
                        storesInfo[i] = storesInfo[i+1]                                     // Current value will now be the next value
                        storesInfo[i+1] = auxVar                                            // Use auxVar that contains previous value of current value
                        swaps = true
                    }
                }
            }
        }
        
        print("Final value of storesInfo is:\n")
        for stores in storesInfo {
            print(stores)
        }
        
        print("Final value of mkAnnotationStores is:\n")
        for stores in mkAnnotationStores {
            print(stores.name)
            print(stores.location)
        }
    }
    
    func displayStoresInView(index: Int) {
        
        // Display stores in View (labels)
        storeName.text = "Tienda: \(storesInfo[index]["NAME"]!)"
        storeDistance.text = "Distancia: a \(storesInfo[index]["DISTTOUSER"]!) metros"
        
        // Display stores as pin buttons
        
    }
    
    override func viewDidLoad() {
        
        if mapParser.verifyValues() {
            print("Copiando valores desde XMLParser")
            for stores in mapParser.posts {
                storesInfo.append(stores)
                let auxTitle: String = stores["NAME"]!
                let auxLatitude: Double = Double(stores["LATITUDE"]!)!
                let auxLongitude: Double = Double(stores["LONGITUDE"]!)!
                mkAnnotationStores.append(Store(name: auxTitle, latitude: auxLatitude, longitude: auxLongitude))
            }

            startLocationServices()
            self.mkMapView.delegate = self
            self.mkMapView.addAnnotations(self.mkAnnotationStores)
            
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
    
    // MapKit Delegate Methods
    
    /*
    - (MKAnnotationView *)mapView:(MKMapView *)mapView
    viewForAnnotation:(id <MKAnnotation>)annotation
    {
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MyCustomAnnotation class]])
    {
    // Try to dequeue an existing pin view first.
    MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
    dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
    
    if (!pinView)
    {
    // If an existing pin view was not available, create one.
    pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
    reuseIdentifier:@"CustomPinAnnotationView"];
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    
    // If appropriate, customize the callout by adding accessory views (code not shown).
    }
    else
    pinView.annotation = annotation;
    
    return pinView;
    }
    
    return nil;
    }
    
    */
    
    // CLLocationManagerDelegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locationManager.location!.coordinate
        print("locations = \(userLocation.latitude) \(userLocation.longitude)")
        
        calculateDistances()
        displayStoresInView(displayIndex)
    }
}