//
//  WeatherInfoView.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import SwiftUI
import Lottie

struct WeatherInfoView<ViewModel: WeatherInfoViewModelling>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack(alignment: .center) {
                
                HStack(alignment: .center, spacing: .zero) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .frame(width: 80, height: 80)
                            .shadow(radius: 10)
                        
                        LottieView(animation: .named(viewModel.showWeather())).playing(loopMode: .loop)
                            .resizable()
                            .frame(width: 70, height: 44)
                    }
                    
                    temperatureView(level: "Low", temperature: viewModel.formatTemperatureData().0)
                        .padding(.horizontal, 20)
                    
                    temperatureView(level: "High", temperature: viewModel.formatTemperatureData().1)
                }
                .padding(.top, 20)
            }
            
        }
        
    }
}

extension WeatherInfoView {
    
    func temperatureView(level: String, temperature: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .frame(width: 80, height: 80)
                .shadow(radius: 10)
            
            VStack(alignment: .center, spacing: 8) {
                Text(temperature + "°C")
                    .bold()
                    .padding(.horizontal, 6)
                
                Text(level)
                    .font(.subheadline)
                
            }
        }
    }
}
