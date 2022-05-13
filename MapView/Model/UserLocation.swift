//
//  UserLocation.swift
//  MapView
//
//  Created by Karnail Singh on 31/01/22.
//

import Foundation
import CoreLocation
import MapKit

// Helper class for Annotation data
class UserLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
