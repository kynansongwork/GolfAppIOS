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

enum CourseRange: Int, Equatable {
    case nearby = 10000
    case close = 50000
    case medium = 100000
    case far = 400000
}

protocol CoursesMapViewModelling: ObservableObject {
    var state: MapViewState { get }
    var courses: [CourseModel] { get set }
    var userLocation: CLLocationCoordinate2D? { get set }
    var locationAuthorisation: CLAuthorizationStatus { get }
    
    func fetchCourses()
    func getLocation()
    func distanceFromUser(filter: CourseRange)
}

class CoursesMapViewModel: CoursesMapViewModelling {
    
    @Published var courses: [CourseModel] = []
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationAuthorisation: CLAuthorizationStatus
    
    private let locationManager: LocationManager
    
    var state: MapViewState = .loading
    var networking: Networking
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(locationManager: LocationManager, networking: Networking) {
        self.networking = networking
        self.locationManager = locationManager
        self.locationAuthorisation = locationManager.locationAuthorisedStatus
        self.fetchCourses()
        
        bindings()
        self.locationManager.requestLocation()
        
        self.distanceFromUser(filter: .nearby)
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
    
    func distanceFromUser(filter: CourseRange) {
        
        print("The user location is \(locationManager.userLocation)")
        
        var filteredCourses: [CourseModel] = []
        
        guard let userLocation else { return }
        
        let user = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        for course in courses {
            
            let location = CLLocation(latitude: course.coordinates.latitude, longitude: course.coordinates.longitude)
            
            let distanceMetres = user.distance(from: location)
            
            if Int(distanceMetres.rounded()) < filter.rawValue {
                filteredCourses.append(course)
                print("\(course.course) is \(distanceMetres) from the user")
            }
        }
        
        self.courses = filteredCourses
    }
}


