//
//  EventScreenViewController.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EventScreenViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    //MapKit
    
    
    //Variables
    var delegate: EventScreenDelegate?
    var text: String?
    var locations = ["Farm", "Cave", "House", "Casino"]
    var locationDescriptions = ["You've come upon a farm. Would you like to search the haystacks?", "You've come upon a cave, would you like to search for hidden pirate treasure?", "You've come upon a house, would you like to defend the homeowners against pirates?", "You've come upon a Casino. Would you like to do some gambling?"]
    //Outlets
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBAction func passButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate?.eventOccured(by: self, adjective: text!)
    }
    @IBOutlet weak var mapView: MKMapView!
    //Functions
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.0025, 0.0025)
//        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
//        mapView.setRegion(region, animated: true)
//        self.mapView.showsUserLocation = true
//    }
    
//        let span = MKCoordinateSpanMake(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let center = location.coordinate
//        let region = MKCoordinateRegion(center: center, span: span)
//        mapView.setRegion(region: r, animated: true)
//        mapView.showUserLocation = true
//    }// Set location to map region
    //ViewDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let ranNumber = arc4random_uniform(4)
        text = locations[Int(ranNumber)]
        textLabel.text = text
        descriptionLable.text = locationDescriptions[Int(ranNumber)]
        
        //MapKit ACtual
//
//        mapView.delegate = self
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//        mapView.showsUserLocation = true

        
        
        // MapKit Below
        
//        mapView.showsUserLocation = true
//        mapView.delegate = self
        
//        let location = CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402)
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "Big Ben"
//        annotation.subtitle = "London"
//        mapView.addAnnotation(annotation)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
