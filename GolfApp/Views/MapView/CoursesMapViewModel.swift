//
//  MapViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 02/10/2024.
//

import Combine
import CoreLocation

enum MapViewState: Equatable {
    case loaded
    case loading
    case error
}

protocol CoursesMapViewModelling: ObservableObject {
    var state: MapViewState { get }
    var courses: [CourseModel] { get set }
    var userLocation: CLLocationCoordinate2D? { get set }
    var locationAuthorisation: CLAuthorizationStatus { get }
    
    func fetchCourses()
    func getLocation()
}

class CoursesMapViewModel: CoursesMapViewModelling {
    
    @Published var courses: [CourseModel] = []
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationAuthorisation: CLAuthorizationStatus
    
    private let locationManager: LocationManager
    
    var state: MapViewState = .loading
    var networking: Networking
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        self.networking = NetworkingManager(url: nil)
        self.locationManager = locationManager
        self.locationAuthorisation = locationManager.locationAuthorisedStatus
        self.fetchCourses()
        
        bindings()
        self.locationManager.requestLocation()
    }
    
    func bindings() {
        
        // Binds location manager updates to model's userLocation
        locationManager.$userLocation
            .assign(to: &$userLocation)
        
        locationManager.$locationAuthorisedStatus
            .assign(to: &$locationAuthorisation)
    }
    
    func getLocation() {
        locationManager.requestLocation()
    }
    
    func fetchCourses() {
        let data = self.networking.getMockData()
        
        if let data = data {
            courses.append(contentsOf: data)
        }
    }
    
    func filterCourses() {}
}


