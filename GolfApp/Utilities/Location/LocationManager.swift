//
//  Untitled.swift
//  GolfApp
//
//  Created by Kynan Song on 24/10/2024.
//

import CoreLocation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationAuthorisedStatus: CLAuthorizationStatus
    @Published var locationError: Error?
    
    private let locationManager = CLLocationManager()
    
    override init() {
        self.locationAuthorisedStatus = .notDetermined
        super.init()
        
        
        locationManagerSetup()
    }
    
    private func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if locationAuthorisedStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() {
        
        let currentAuthStatus = locationManager.authorizationStatus
        
        switch currentAuthStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            //TODO: Change this later
            print("Location permissions are denied")
                        locationError = NSError(domain: "LocationManager",
                                              code: 1,
                                              userInfo: [NSLocalizedDescriptionKey: "Location permissions are denied"])
        default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        //TODO: Handle error later
        locationError = error
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorisedStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
                case .authorizedWhenInUse, .authorizedAlways:
                    manager.startUpdatingLocation()
                case .denied, .restricted:
                    locationError = NSError(domain: "LocationManager",
                                          code: 1,
                                          userInfo: [NSLocalizedDescriptionKey: "Location access denied"])
                case .notDetermined:
                    manager.requestWhenInUseAuthorization()
                @unknown default:
                    break
                }
    }
    
}
