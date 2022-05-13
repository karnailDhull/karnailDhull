//
//  MapViewModel.swift
//  MapView
//
//  Created by Karnail Singh on 07/02/22.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel {

    var mapItems = [MKMapItem]()

    func userLocations() -> [MKAnnotation] {

        let annotations =  mapItems.compactMap { mapItem -> UserLocation in
            let placeMark = mapItem.placemark
       let userLocation = UserLocation(title: placeMark.title!,
                                       coordinate: CLLocationCoordinate2D(latitude: placeMark.coordinate.latitude,
                                                                          longitude: placeMark.coordinate.longitude))
            return userLocation
        }
        return annotations
    }

    // Dummy temporary Location for ploating marker
    class func userLocations() -> [UserLocation] {

        let delhi = UserLocation(title: "Delhi",
                                 coordinate: CLLocationCoordinate2D(latitude: 28.99, longitude: 77.00))
        let mumbai = UserLocation(title: "Mumbai",
                                  coordinate: CLLocationCoordinate2D(latitude: 19.076090, longitude: 72.877426))
        let karnatak = UserLocation(title: "Karnataka",
                                    coordinate: CLLocationCoordinate2D(latitude: 14.167040, longitude: 75.040298))
        let westBengal = UserLocation(title: "West Bengal",
                                      coordinate: CLLocationCoordinate2D(latitude: 26.540457, longitude: 88.719391))
        let kerala = UserLocation(title: "Kerala",
                                  coordinate: CLLocationCoordinate2D(latitude: 9.931233, longitude: 76.267303))

        return [delhi, mumbai, karnatak, westBengal, kerala]
    }

}
