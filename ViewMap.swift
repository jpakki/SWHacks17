//
//  ViewController.swift
//  GeoTargeting
//
//  Created by Eugene Trapeznikov on 4/23/16.
//  Copyright © 2016 Evgenii Trapeznikov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
import Contacts

class ViewMap: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var messageButton: UIButton!
    let address = "301 E Orange St, Tempe, AZ 85287"
    var coords: CLLocationCoordinate2D?


    let locationManager = CLLocationManager()
    var monitoredRegions: Dictionary<String, Date> = [:]
    
    let viewContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var fetchResults = [User]()

    let messageComposer = MessageComposer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.messageButton.isHidden = true
        
        // setup locationManager
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // setup mapView
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.mapType = MKMapType.hybrid

        // setup test data
        setupData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            // authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            //showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupData() {
        // check if can monitor regions
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
           
            
            
//            if  try viewContext.fetch(request!) as! [User] {
//                
//            }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            var x = 0
            // Execute the fetch request, and cast the results to an array of LogItem objects
            fetchResults = ((try? viewContext.fetch(fetchRequest)) as? [User])!
            
            
            x = fetchResults.count
            print(x)
            
            let result = fetchResults[0].name
            print(result!)
            // region data
            let title = "Home"
             //let coordinate = CLLocationCoordinate2DMake(33.417815, -111.934374)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(fetchResults[0].lat), CLLocationDegrees(fetchResults[0].long))
            let regionRadius = fetchResults[0].radius
            
            // setup region
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                         longitude: coordinate.longitude), radius: CLLocationDistance(regionRadius), identifier: title)
            locationManager.startMonitoring(for: region)
            
            // setup annotation
            let restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            mapView.addAnnotation(restaurantAnnotation)
            
            
            // setup circle
            let circle = MKCircle(center: coordinate, radius: CLLocationDistance(regionRadius))
            mapView.add(circle)
        }
        else {
            print("System can't track regions")
        }
    }
    
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.lineWidth = 1.0
        circleRenderer.strokeColor = .purple
        circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
        return circleRenderer
    }
    
    // MARK: - CLLocationManagerDelegate
    
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        showAlert("enter \(region.identifier)")
//        monitoredRegions[region.identifier] = Date()
//    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlert()
        monitoredRegions.removeValue(forKey: region.identifier)
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        updateRegionsWithLocation(locations[0])
//    }
    
    // MARK: - Comples business logic
    
//    func updateRegionsWithLocation(_ location: CLLocation) {
//        
//        let regionMaxVisiting = 10.0
//        var regionsToDelete: [String] = []
//
//        for regionIdentifier in monitoredRegions.keys {
//            if Date().timeIntervalSince(monitoredRegions[regionIdentifier]!) > regionMaxVisiting {
//                showAlert("Thanks for visiting our restaurant")
//                
//                regionsToDelete.append(regionIdentifier)
//            }
//        }
//        
//        for regionIdentifier in regionsToDelete {
//            monitoredRegions.removeValue(forKey: regionIdentifier)
//        }
//    }
    
    // MARK: - Helpers
    func sendTextMessageButtonTapped() {
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    func yesAlertTriggered(){
        showLostAlert()
    }
    
    func showAlert() {
//        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alert, animated: true, completion: nil)
//        
//        self.messageButton.isHidden = false
        
        
        let alertController = UIAlertController(title: "Lost", message: "Are you lost?", preferredStyle: .alert)
        
        // create an OK action
        let YESAction = UIAlertAction(title: "YES", style: .default) { (action) in
            // handle response here.
            self.yesAlertTriggered()
        }
        let NOAction = UIAlertAction(title: "NO", style: .default) { (action) in
        }
        
        // add the OK action to the alert controller
        alertController.addAction(YESAction)
        alertController.addAction(NOAction)
        
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
            //self.sendTextMessageButtonTapped()
        }
    }
    
    func showLostAlert() {
        //        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        //        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
        //            alert.dismiss(animated: true, completion: nil)
        //        }))
        //        self.present(alert, animated: true, completion: nil)
        //
        //        self.messageButton.isHidden = false
        
        
        let alertController = UIAlertController(title: "Here's some help!", message: "Get some help!", preferredStyle: .alert)
        
        // create an OK action
        let YESAction = UIAlertAction(title: "Message Caregiver", style: .default) { (action) in
            // handle response here.
            self.sendTextMessageButtonTapped()
        }
        let NOAction = UIAlertAction(title: "GPS Directions", style: .default) { (action) in
            self.direct()
        }
        
        // add the OK action to the alert controller
        alertController.addAction(YESAction)
        alertController.addAction(NOAction)
        
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
            //self.sendTextMessageButtonTapped()
        }
    }
    
    @IBAction func messageButtonAction(_ sender: Any) {
        self.sendTextMessageButtonTapped()
    }
    
    @IBAction func directionButtonAction(_ sender: Any) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { placemarks, error in
            
                if error != nil {
                    print("Geocode failed with error: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    self.coords = location!.coordinate
                    
                    self.showMap()
                    
                }
        }
    }
    
    func direct(){
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { placemarks, error in
            
            if error != nil {
                print("Geocode failed with error: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                self.coords = location!.coordinate
                
                self.showMap()
                
            }
        }
    }
    
    func showMap() {
        let addressDict =
            [CNPostalAddressStreetKey: address]
        
        let place = MKPlacemark(coordinate: coords!,
                                addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: place)
        
        let options = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeWalking]
        
        mapItem.openInMaps(launchOptions: options)
    }
}

