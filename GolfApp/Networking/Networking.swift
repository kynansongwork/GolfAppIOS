//
//  Networking.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import Foundation

struct ResponseData: Decodable {
    var courses: [CourseModel]
}

enum SwitchEndpoints {
    case weather
}

enum APIError: Error {
    case invalidUrl(description: String)
    case decodingError(Error)
    case invalidResponse
    case networkError(Error)
}

protocol Networking {
    func getData<T: Decodable>(request: URLRequest) async throws -> T?
    
    func changeApiUrl(endpoint: SwitchEndpoints)
    func getCoursesData(request: URLRequest) async throws -> CourseModel
    func getMockData() -> [CourseModel]?
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse?
}

class NetworkingManager: Networking {
    
    //TODO: Make this a singleton?
    
    var apiURL: URL?
    var urlSession: URLSessionProtocol
    
    init(url: URL?, urlSession: URLSessionProtocol) {
        apiURL = url
        self.urlSession = urlSession
    }
    
    func getData<T: Decodable>(request: URLRequest) async throws -> T? {
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }

    func getCoursesData(request: URLRequest) async throws -> CourseModel {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(CourseModel.self, from: data)
    }
    
    func getMockData() -> [CourseModel]? {
        //TODO: Will use ScottishGolfCourses.json until either I build a server or stick the data up on firebase.
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
    
    func changeApiUrl(endpoint: SwitchEndpoints) {
        switch endpoint {
        case .weather:
            apiURL = Endpoints.weatherEndpoint
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse? {

        changeApiUrl(endpoint: .weather)
        
        guard let url = apiURL else { return nil }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil}
        
        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "daily", value: ["temperature_2m_max",
                                                "temperature_2m_min",
                                                "wind_speed_10m_max",
                                                "wind_direction_10m_dominant",
                                                "precipitation_sum",
                                                "precipitation_probability_max",
                                                "cloud_cover_mean"].joined(separator: ",")),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        
        guard let url = components.url else {
            throw WeatherError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        guard let weather: WeatherResponse = try? await getData(request: request) else { return nil }
        
        return weather
    }
}


