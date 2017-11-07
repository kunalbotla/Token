//
//  SecondViewController.swift
//  Parking Meter Reminder
//
//  Created by Kunal Botla on 10/20/17.
//  Copyright © 2017 Kunal Botla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitudeSavedLocation = 0
    var longitudeSavedLocation = 0
    
    @IBOutlet weak var locationMapView: MKMapView!
    
    @IBAction func saveLocationButton(_ sender: UIButton) {
        saveLocation()
    }
    
        let manager = CLLocationManager()
   
//Functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        let location = location[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        locationMapView.setRegion(region, animated: true)
        
        self.locationMapView.showsUserLocation = true
    
    func saveLocation() {
        latitudeSavedLocation = Int(location.coordinate.latitude)
        longitudeSavedLocation = Int(location.coordinate.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation
        annotation.title = "Parked Car"
        annotation.subtitle = "Saved Parked Car Location"
        locationMapView.addAnnotation(annotation)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

