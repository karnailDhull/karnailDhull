//
//  ViewController.swift
//  MapView
//
//  Created by Karnail Singh on 28/01/22.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: [MKMapItem])
}

class AppleViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController?
    private let mapViewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let locationSearchTable = storyboard?.instantiateViewController(
            withIdentifier: ControllerConstant.locationSearchTableViewController) as?
            LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        configureSearchBar()
        locationSearchTable?.mapView = mapView
        locationSearchTable?.resultSearchController = resultSearchController
        locationSearchTable?.handleMapSearchDelegate = self
    }

    func configureSearchBar() {
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = StringConstant.searchforplaces
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
}

extension AppleViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return AnnotationView.mapView(mapView, viewFor: annotation)
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        AnnotationView.mapView(mapView, annotationView: view, calloutAccessoryControlTapped: control)
    }
}

extension AppleViewController: HandleMapSearch {
    func dropPinZoomIn(placemark: [MKMapItem]) {
        mapView.removeAnnotations(mapView.annotations)
        mapViewModel.mapItems = placemark
        let placemark = placemark.first?.placemark
        let span = MKCoordinateSpan(latitudeDelta: LocationConstant.latLongSpan,
                                    longitudeDelta: LocationConstant.latLongSpan)
        let region = MKCoordinateRegion(center: placemark!.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotations(mapViewModel.userLocations())
    }
}

extension AppleViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
           LocationManager.locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               guard let location = locations.first else { return }
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
