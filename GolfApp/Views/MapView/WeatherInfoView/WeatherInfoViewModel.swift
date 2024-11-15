//
//  WeatherInfoViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

protocol WeatherInfoViewModelling: ObservableObject {
    func formatTemperatureData() -> (String, String)
    func showWeather() -> String
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
    
    func showWeather() -> String {
        if dailyWeather.isSunnyToday {
            return "sunny"
        } else if dailyWeather.precipitationProbability[0] > 50 {
            return "rain"
        } else {
            return showCloudCoverlevels()
        }
    }
    
    func showCloudCoverlevels() -> String {
        guard let cloudCover = dailyWeather.cloudCover.first else {
            return "questionmark.diamond"
        }
        
        //TODO: Expand to include rain etc later
        switch cloudCover {
            case 0...50:
            //Low
                return "cloudSun"
            case 26...50:
            //Mid
                return "hiddenSunCloud"
            case 51...75:
            //High
                return "cloudy"
            case 76...100:
            //Full cover
                return "cloudMist"
        default:
            return "cloudy"
        }
    }
}
