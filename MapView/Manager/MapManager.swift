//
//  MapManager.swift
//  MapView
//
//  Created by Karnail Singh on 31/01/22.
//

import Foundation
import CoreLocation
import MapKit

class MapManager {

    class func openAppleMap(with mapItems: [MKMapItem], launchOptions: [String: String]) {
        MKMapItem.openMaps(with: mapItems, launchOptions: launchOptions)
    }
    
    class func openGoogleMap(with location: CLLocationCoordinate2D) {
        let lat = location.latitude
        let long = location.longitude

        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            // Open in browser
            if let urlDestination = URL(string:
                                            "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
}
