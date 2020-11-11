//
//  ViewController.swift
//  MyLocations
//
//  Created by Tyler Moore on 10/29/20.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var tagButton: UIButton!
    @IBOutlet var getButton: UIButton!
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var updatingLocation = false
    var lastLocationError: Error?
    
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    var timer: Timer?
    var prevNavBarHiddenState = false
    
    // MARK:- Actions
    @IBAction func getLocation() {
        placemark = nil
        lastGeocodingError = nil
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        updateLabels()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navHiddenState = navigationController?.isNavigationBarHidden {
            prevNavBarHiddenState = navHiddenState
        }
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = prevNavBarHiddenState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is CurrentLocationToLocationDetailsSegue, let controller = segue.destination as? LocationDetailsViewController {
            controller.coordinate = location!.coordinate
            controller.placemark = placemark
        }
    }
}

class CurrentLocationToLocationDetailsSegue: UIStoryboardSegue {}
