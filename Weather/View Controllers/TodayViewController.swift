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

class TodayViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    // MARK: Properties
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var location = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        tryToGetLocationPermission()
    }
    
    func tryToGetLocationPermission() {
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
        
        // create an object to download weather details for today
        let todayDetails = Today()
        
        todayDetails.downloadData(location: location) { (data: condition) in
        
            //update the UI on the main queue
            DispatchQueue.main.async {
                self.updateLabels(with: data)
            }
        }
    }
    
    // update labels and icon for the view
    func updateLabels(with data: condition) {
        cityLabel.text = data.location!
        temperatureLabel.text = "temperature: \(data.temperatureString!)"
        feelsLikeLabel.text = "feels like: \(data.feelsLikeString!)"
        weatherLabel.text = data.weather!
        
        //set the icon image
        weatherIcon.setCustomImage( getIconURL(for: data.icon) )
    }
    
    
    
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass location if the segue is to the 10 Day Forecast screen
        if segue.identifier == "10DayForecast" {
            if let vc = segue.destination as? TenDayForecastTableViewController {
                vc.location = self.location
            }
            
        }
    }
    
    
}
