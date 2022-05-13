//
//  LocationManager.swift
//  MapView
//
//  Created by Karnail Singh on 02/02/22.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager {

    static let locationManager = LocationManager()
    private override init() {
        super.init()
        checkLocationServices()
        desiredAccuracy = kCLLocationAccuracyBest
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
             checkLocationAuthorization()
        } else {

        }
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
           startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("not getting location")
        }
    }
}
