//
//  MapViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 02/10/2024.
//

import Combine
import CoreLocation
import MapKit

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
    var distance: CGFloat { get set }
    var networking: Networking { get }
    
    func fetchCourses()
    func getLocation()
    func distanceFromUser(filter: CGFloat)
    
    func getDirectionsToCourse(course: CourseModel) async -> MKRoute?
}

class CoursesMapViewModel: CoursesMapViewModelling {
    
    @Published var courses: [CourseModel] = []
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationAuthorisation: CLAuthorizationStatus
    @Published var distance: CGFloat = 10000 {
        didSet {
            self.distanceFromUser(filter: distance)
        }
    }
    
    private let locationManager: LocationManager
    private var allCourses: [CourseModel] = []
    
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
        
        self.distanceFromUser(filter: 10000)
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
            allCourses = courses
        }
    }
    
    func getDirectionsToCourse(course: CourseModel) async -> MKRoute? {
        
        let coordinates = course.coordinates
        let location = CLLocationCoordinate2D.init(latitude: coordinates.latitude,
                                                   longitude: coordinates.longitude)
        
        guard let route = await locationManager.showDirections(location: location) else { return nil }
        
        return route
    }
    
    ///Used for filtering out courses based on distance from user.
    func distanceFromUser(filter: CGFloat) {
        
        var filteredCourses: [CourseModel] = []
        
        guard let userLocation else { return }
        
        let user = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        for course in allCourses {
            
            let location = CLLocation(latitude: course.coordinates.latitude, longitude: course.coordinates.longitude)
            
            let distanceMetres = user.distance(from: location)
            
            if CGFloat(distanceMetres.rounded()) < filter {
                filteredCourses.append(course)
                //print("\(course.course) is \(distanceMetres) from the user")
            }
        }
        
        self.courses = filteredCourses
    }
}


