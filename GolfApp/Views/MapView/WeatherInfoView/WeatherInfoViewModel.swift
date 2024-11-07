//
//  WeatherInfoViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

protocol WeatherInfoViewModelling: ObservableObject {
    func formatTemperatureData() -> (String, String)
}

class WeatherInfoViewModel: WeatherInfoViewModelling {
    
    let dailyWeather: DailyWeather
    
    init(dailyWeather: DailyWeather) {
        self.dailyWeather = dailyWeather
    }
    
    func formatTemperatureData() -> (String, String) {
        guard let minTemp = dailyWeather.temperature2mMin.first, let maxTemp = dailyWeather.temperature2mMax.first else {
            return ("", "")
        }
        
        return (minTemp.toString(to: 1), maxTemp.toString(to: 1))
    }
}
