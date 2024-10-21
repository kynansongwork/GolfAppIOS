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
    
    func fetchCourses()
}

class CoursesMapViewModel: CoursesMapViewModelling {
    
    @Published var courses: [CourseModel] = []
    
    var state: MapViewState = .loading
    var networking: Networking
    
    init() {
        self.networking = NetworkingManager(url: nil)
        
        self.fetchCourses()
    }
    
    func fetchCourses() {
        let data = self.networking.getMockData()
        
        if let data = data {
            courses.append(contentsOf: data)
        }
    }
    
    func filterCourses() {}
}


