//
//  MockNetworking.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

enum MockError: Error, Equatable {
    case error
}

class MockURLSession: URLSessionProtocol {
    let data: Data?
    let response: URLResponse?
    let error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let data = data, let response = response else {
            throw error!
        }
        return (data, response)
    }
}

class MockNetworking: Networking {
    
    var apiURL: URL?
    
    init(url: URL?) {
        apiURL = url
    }
    
    var mockWeatherData: WeatherResponse {
        WeatherResponse(latitude: 55.953251,
                        longitude: -3.188267,
                        timezone: "GMT",
                        daily: mockDailyWeather)
    }
    
    var mockDailyWeather: DailyWeather {
        DailyWeather(time: ["2024-10-29", "2024-10-30"],
                     temperature2mMax: [14.5, 14.3],
                     temperature2mMin: [10.8, 9.9],
                     windSpeed10mMax: [16.4, 14.0],
                     windDirection10mDominant: [251.0, 242.0],
                     precipitation: [0.0, 0.0],
                     precipitationProbability: [0.0, 0.0],
                     cloudCover: [74, 62])
    }
    
    func getData<T>(request: URLRequest) async throws -> T? {
        let mockData: WeatherResponse = mockWeatherData
        return mockData as? T
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse? {
        let request = URLRequest(url: apiURL!)
        return try await getData(request: request)
    }
    
    func changeApiUrl(endpoint: SwitchEndpoints) {}
    
    func getCoursesData(request: URLRequest) async throws -> CourseModel {
        return CourseModel(course: "", region: "", postcode: "", coordinates: Coordinates(latitude: 1, longitude: 1), type: .heathland, yrds: 1, holes: 1, par: 1, golfshakeRating: 2, coursePrivate: false, courseCourseHC: 1, courseMyRating: 1, courseOfficialRating: 1, costSummer: 1, costWinter: 1, courseHC: 1, myRating: 1, officialRating: 1, courseRating: 1, slopeRating: 1, website: "")
    }
    
    func getMockData() -> [CourseModel]? {
        if let url = Bundle.main.url(forResource: "ScottishGolfCourses", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CourseModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
