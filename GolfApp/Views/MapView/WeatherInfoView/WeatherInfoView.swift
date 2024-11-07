//
//  WeatherInfoView.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import SwiftUI

struct WeatherInfoView<ViewModel: WeatherInfoViewModelling>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                
                HStack(spacing: .zero) {
                    Image(systemName: viewModel.showCloudCoverlevels())
                        .resizable()
                        .frame(width: 70, height: 44)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                
                
                Text("The temperature at this location will be: \(viewModel.formatTemperatureData().0) to \(viewModel.formatTemperatureData().1) degreed celsius.")
                    .padding(.all, 20)
            }
            
        }
        
    }
}
