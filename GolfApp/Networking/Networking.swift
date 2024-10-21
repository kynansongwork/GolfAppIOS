//
//  Networking.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import Foundation

enum APIError: Error {
    case invalidUrl(description: String)
}

struct ResponseData: Decodable {
    var courses: [CourseModel]
}

protocol Networking {
    func getData<T: Decodable>(request: URLRequest) async throws -> T?
    
    func getCoursesData(request: URLRequest) async throws -> CourseModel
    func getMockData() -> [CourseModel]?
}

class NetworkingManager: Networking {
    
    //TODO: Make this a singleton?
    
    var apiURL: URL?
    
    init(url: URL?) {
        apiURL = url
    }
    
    func getData<T: Decodable>(request: URLRequest) async throws -> T? {
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
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
    
}

