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
    
    var latitudeCurrentLocation: CLLocationDegrees
    var longitudeCurrentLocation: CLLocationDegrees
    var speedCurrentLocation: CLLocationDegrees
    
    var latitudeSavedLocation = 0
    var longitudeSavedLocation = 0
    
    @IBOutlet weak var locationMapView: MKMapView!
    
    @IBAction func saveLocationButton(_ sender: UIButton) {
        saveLocation()
    }
    
    @IBAction func directionsButton(_ sender: UIButton) {
        directions()
    }
    
    let manager = CLLocationManager()
//Variables/Constants
    
//Functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        let location = location[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myCurrentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myCurrentLocation, span)
        locationMapView.setRegion(region, animated: true)
        
        latitudeCurrentLocation = Int(location.coordinate.latitude)
        longitudeCurrentLocation = Int(location.coordinate.longitude)
        speedCurrentLocation = Int(location.speed)
        
        self.locationMapView.showsUserLocation = true
        
        //Testing
         print("RawA", myCurrentLocation)
         print("RawA latCL (var)", latitudeCurrentLocation)
         print("RawA longCL (var)", longitudeCurrentLocation)
         print("RawA speedCL (var)", speedCurrentLocation)
        
         print("RawA latCL (manager)", location.coordinate.latitude)
         print("RawA longCL (manager)", location.coordinate.longitude)
         print("RawA speedCL (manager)", location.speed)
    }
    
    func saveLocation() {
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let myCurrentLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latitudeCurrentLocation), CLLocationDegrees(longitudeCurrentLocation))
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myCurrentLocation, span)
        locationMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = myCurrentLocation
        annotation.title = "Parked Car"
        annotation.subtitle = "Saved Parked Car Location"
        locationMapView.addAnnotation(annotation)
        
        latitudeSavedLocation = latitudeCurrentLocation
        longitudeSavedLocation = longitudeCurrentLocation
        
        //Testing of the location simplification bug. Caused due to lat, and long getting simplified. Must use location in how it is treated in func locationManager, let myCurrentLocation (Displayed 
        print("Saved", latitudeSavedLocation,longitudeSavedLocation)
        print("Current", latitudeCurrentLocation,longitudeCurrentLocation)
        print("RawB", myCurrentLocation)
        }
    
    func directions() {
        let regionDistance:CLLocationDistance = 1000;
        let mySavedLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(latitudeSavedLocation), CLLocationDegrees(longitudeSavedLocation))
        let regionSpan = MKCoordinateRegionMakeWithDistance(mySavedLocation, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate:regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: mySavedLocation)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Parked Car - Token"
        mapItem.openInMaps(launchOptions: options)
    }
    
    func speedWarning() {
        func createAlert(title:String, message:String) {
            var speedWarningSent = false
            print(speedWarningSent)
            
            //Bug Testing
            print("RawB Speed", speedCurrentLocation)
            
            if speedCurrentLocation < 20 {
                if speedWarningSent == false {
                    let title:String = "Do Not Use Token When Drving"
                    let message:String = "Token has detected that you are at driving speeds"
                    
                    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style:UIAlertActionStyle.default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                        
                        speedWarningSent = true
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
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

