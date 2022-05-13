//
//  GoogleMapViewController.swift
//  MapView
//
//  Created by Karnail Singh on 03/02/22.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 28.99, longitude: 77.01, zoom: 4)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        let location =  MapViewModel.userLocations()
        for userlocation in location {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:
                                            userlocation.coordinate.latitude,
                                            longitude: userlocation.coordinate.longitude)
            marker.title = userlocation.title
            marker.map = mapView
        }
    }
}

extension GoogleMapViewController: GMSMapViewDelegate {

    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        return true
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        MapManager.openGoogleMap(with: marker.position)
    }
}
