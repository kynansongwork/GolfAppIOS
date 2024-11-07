//
//  Weather.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

enum WeatherViewState {
    case loaded(WeatherResponse)
    case loading
    case error
}

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let daily: DailyWeather
}

struct DailyWeather: Codable {
    let time: [String]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    
    let windSpeed10mMax: [Double]
    let windDirection10mDominant: [Double]
    
    let precipitation: [Double]
    let precipitationProbability: [Double]

    let cloudCover: [Int]
    
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        
        case windSpeed10mMax = "wind_speed_10m_max"
        case windDirection10mDominant = "wind_direction_10m_dominant"
        
        case precipitation = "precipitation_sum"
        case precipitationProbability = "precipitation_probability_max"
        
        case cloudCover = "cloud_cover_mean"
    }
}

enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
}
