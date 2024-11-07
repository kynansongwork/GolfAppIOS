//
//  WeatherInfoViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

protocol WeatherInfoViewModelling: ObservableObject {
    func formatTemperatureData() -> (String, String)
    func showCloudCoverlevels() -> String
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
    
    func showCloudCoverlevels() -> String {
        guard let cloudCover = dailyWeather.cloudCover.first else {
            return "questionmark.diamond"
        }
        
        //TODO: Expand to include rain etc later
        switch cloudCover {
            case 0...10:
                return "sun.max"
            case 11...50:
            //Low
                return "cloud.sun"
            case 26...50:
            //Mid
                return "cloud.sun.fill"
            case 51...75:
            //High
                return "icloud"
            case 76...100:
            //Full cover
                return "icloud.fill"
        default:
            return "questionmark.diamond"
        }
    }
}
