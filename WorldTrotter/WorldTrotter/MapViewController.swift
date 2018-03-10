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
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
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
        
        
        let showLocationButton = UIButton(type: .system)
        showLocationButton.frame.size = CGSize(width: 50, height: 50)
        showLocationButton.setBackgroundImage(UIImage(named: "compass"), for: .normal)
        print(showLocationButton.frame)
        showLocationButton.layer.cornerRadius = 25
        showLocationButton.translatesAutoresizingMaskIntoConstraints = false
        showLocationButton.addTarget(self, action: #selector(MapViewController.showLocationButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(showLocationButton)
        
        let showBtnTopConstraint = showLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let showBtnBottomConstraint = showLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        
        showBtnTopConstraint.isActive = true
        showBtnBottomConstraint.isActive = true
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
                centerMapWithLocation(userLocation)
            }
        }
    }
    
    func centerMapWithLocation(_ location: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let newLocation = userLocation.location {
            if self.userLocation == nil {
                centerMapWithLocation(newLocation)
            }
            
            self.userLocation = newLocation
        }
    }
}
