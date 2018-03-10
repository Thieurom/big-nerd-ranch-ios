//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Doan Le Thieu on 3/6/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var userLocation: CLLocation?
    var annotations = [MKPointAnnotation]()
    var pinIndex = 0
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // MARK: Segmented Control to select map type
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // MARK: Show user's current location button
        
        let showLocationButton = UIButton(type: .system)
        showLocationButton.frame.size = CGSize(width: 50, height: 50)
        showLocationButton.setBackgroundImage(UIImage(named: "compass"), for: .normal)
        showLocationButton.layer.cornerRadius = 25
        showLocationButton.translatesAutoresizingMaskIntoConstraints = false
        showLocationButton.addTarget(self, action: #selector(MapViewController.showLocationButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(showLocationButton)
        
        let showBtnTrailingConstraint = showLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let showBtnBottomConstraint = showLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        
        showBtnTrailingConstraint.isActive = true
        showBtnBottomConstraint.isActive = true
        
        // MARK: Drop pins for 3 pre-defined locations
        
        let showPinButton = UIButton(type: .system)
        showPinButton.frame.size = CGSize(width: 50, height: 50)
        showPinButton.setBackgroundImage(UIImage(named: "pin"), for: .normal)
        showPinButton.layer.cornerRadius = 25
        showPinButton.translatesAutoresizingMaskIntoConstraints = false
        showPinButton.addTarget(self, action: #selector(MapViewController.showPinButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(showPinButton)
        
        let pinBtnTrailingConstraint = showPinButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let pinBtnBottomConstraint = showPinButton.bottomAnchor.constraint(equalTo: showLocationButton.topAnchor, constant: -5)
        
        pinBtnTrailingConstraint.isActive = true
        pinBtnBottomConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 18.679585, longitude: 105.681335)
        annotation1.title = "Nghe An"
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 16.047079, longitude: 108.206230)
        annotation2.title = "Da Nang"
        
        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 10.762622, longitude: 106.660172)
        annotation3.title = "Ho Chi Minh City"
        
        annotations.append(annotation1)
        annotations.append(annotation2)
        annotations.append(annotation3)
        mapView.addAnnotations(annotations)
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func showLocationButtonTapped(_ sender: UIButton) {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            if let userLocation = userLocation {
                centerMapWithLocationCoordinate(userLocation.coordinate)
            }
        }
    }
    
    @objc func showPinButtonTapped(_ sender: UIButton) {
        centerMapWithLocationCoordinate(annotations[pinIndex].coordinate)
        pinIndex = (pinIndex + 1) % annotations.count
    }
    
    func centerMapWithLocationCoordinate(_ locationCoordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(locationCoordinate, 500, 500)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let newLocation = userLocation.location {
            if self.userLocation == nil {
                centerMapWithLocationCoordinate(newLocation.coordinate)
            }
            
            self.userLocation = newLocation
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't show pin for user's current location
        if annotation.coordinate.latitude == userLocation?.coordinate.latitude &&
            annotation.coordinate.longitude == userLocation?.coordinate.longitude {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            view?.canShowCallout = true
            view?.animatesDrop = true
            view?.pinTintColor = MKPinAnnotationView.redPinColor()
        } else {
            view?.annotation = annotation
        }
        
        return view
    }
}
