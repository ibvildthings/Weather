//
//  ViewController.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var location = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.location = location
        
        let object = DayHourly()
        object.downloadData(location: location)
        
    }
    
    
}



//- Download JSON data for given coordinates.
//- Create a struct to store the data.
//- Parse values for days
//- Create UI to display date.
