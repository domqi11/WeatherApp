//
//  Location Manager.swift
//  MyWeather
//
//  Created by Dominic  Qi on 10/5/2025.
//
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var locationName: String = "Loading..."
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func requestLocation() {
        isLoading = true
        
        // Always request authorization first
        locationManager.requestWhenInUseAuthorization()
        
        // Check if we're in simulator - if so, use a default location
        #if targetEnvironment(simulator)
        print("Running in simulator - using default location")
        // Melbourne coordinates (since you're in Australia)
        self.location = CLLocation(latitude: -37.8136, longitude: 144.9631)
        self.locationName = "Melbourne"
        self.isLoading = false
        #else
        locationManager.requestLocation()
        #endif
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .restricted, .denied:
            errorMessage = "Location permission is required. Please enable location services in Settings."
            isLoading = false
        case .notDetermined:
            // Wait for user response
            break
        @unknown default:
            errorMessage = "Unknown location authorization status"
            isLoading = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.location = location
        self.isLoading = false
        
        // Get city name
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self.errorMessage = "Error getting location name"
                return
            }
            
            if let placemark = placemarks?.first, let city = placemark.locality {
                self.locationName = city
            } else if let placemark = placemarks?.first, let area = placemark.administrativeArea {
                self.locationName = area
            } else {
                self.locationName = "Unknown Location"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        
        #if targetEnvironment(simulator)
        // Use a default location for simulator
        self.location = CLLocation(latitude: -37.8136, longitude: 144.9631)
        self.locationName = "Melbourne"
        self.isLoading = false
        #else
        self.errorMessage = "Error getting location: \(error.localizedDescription)"
        self.isLoading = false
        #endif
    }
}
