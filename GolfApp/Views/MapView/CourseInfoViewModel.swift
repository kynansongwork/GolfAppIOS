//
//  CourseInfoViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Combine

protocol CourseInfoViewModelling: ObservableObject {
    var course: CourseModel { get }
    var state: WeatherViewState { get set }
    
    func getWeatherData() async throws
}

class CourseInfoViewModel: CourseInfoViewModelling {
    
    @Published var state: WeatherViewState = .loading
    
    var networking: Networking
    var course: CourseModel
    
    init(course: CourseModel, networking: Networking) {
        self.course = course
        self.networking = networking
        
        Task {
            try await self.getWeatherData()
        }
        
    }
    
    @MainActor
    func getWeatherData() async throws {

        guard let weatherData = try await self.networking.fetchWeather(latitude: course.coordinates.latitude,
                                                                       longitude: course.coordinates.longitude) else {
            state = .error
            return
        }
        
        state = .loaded(weatherData)
    }
}
