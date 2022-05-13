//
//  LocationView.swift
//  MapView
//
//  Created by Karnail Singh on 31/01/22.
//

import Foundation
import MapKit

class AnnotationView: MKAnnotationView {

  class func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {        
        if annotation is MKUserLocation {
            return nil
        }
       let reuseId = StringConstant.pinView
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .purple
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
  class func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                     calloutAccessoryControlTapped control: UIControl) {
        let selectedLoc = view.annotation
        let currentLocMapItem = MKMapItem.forCurrentLocation()
        let selectedPlacemark = MKPlacemark(coordinate: selectedLoc!.coordinate, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        let mapItems = [selectedMapItem, currentLocMapItem]
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
         MapManager.openAppleMap(with: mapItems, launchOptions: launchOptions)
    }
}
