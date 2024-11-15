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
    
    //From Claude
    func isSunny(forDay index: Int) -> Bool {
        guard index < cloudCover.count else { return false }
        
        // Consider it sunny if cloud cover is less than 30% and precipitation probability is low
        let isLowCloudCover = cloudCover[index] < 30
        let isLowPrecipitation = precipitationProbability[index] < 20
        
        return isLowCloudCover && isLowPrecipitation
    }
    
    // Helper to get weather description
    func getWeatherDescription(forDay index: Int) -> String {
        guard index < cloudCover.count else { return "Unknown" }
        
        if isSunny(forDay: index) {
            return "Sunny"
        } else if precipitationProbability[index] > 50 {
            return "Rainy"
        } else if cloudCover[index] >= 70 {
            return "Cloudy"
        } else {
            return "Partly Cloudy"
        }
    }
    
    // Helper to get the current day's data
    var todayIndex: Int? {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return time.firstIndex(of: formatter.string(from: today))
    }
    
    // Convenience property for today's weather
    var isSunnyToday: Bool {
        guard let today = todayIndex else { return false }
        return isSunny(forDay: today)
    }
}

enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
}
