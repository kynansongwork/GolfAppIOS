//
//  CourseInfoView.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI
import CoreLocation

struct CourseInfoView<ViewModel: CourseInfoViewModelling>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var courseInfo: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                InfoRow(message: "Rating:", data: viewModel.course.courseRating?.toString(to: 2) ?? 0.toString(to: 2))
                InfoRow(message: "Holes:", data: String(viewModel.course.holes ?? 0))
            }
            
            HStack(spacing: 8) {
                InfoRow(message: "Size:", data: String(viewModel.course.yrds) + "yards")
                InfoRow(message: "Type:", data: viewModel.course.type.rawValue.capitalized)
            }
            
            
            if let summerCost = viewModel.course.costSummer {
                InfoRow(message: "Cost Summer:", data: "£\(summerCost)")
            } else {
                Text("Closed").bold()
            }
            
            if let winterCost = viewModel.course.costWinter {
                InfoRow(message: "Cost Winter:", data: "£\(winterCost)")
            }
        }
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            VStack(spacing: .zero) {
                Text(viewModel.course.course)
                    .font(.title)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.horizontal, 20)
                Text(viewModel.course.region)
                    .font(.subheadline)
                Text(viewModel.course.postcode ?? "Closed")
                    .font(.subheadline)
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 4) {
                courseInfo
                    .padding(.bottom, 20)
                
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded(let weather):
                    WeatherInfoView(viewModel: WeatherInfoViewModel(dailyWeather: weather.daily))
                        .padding(.horizontal, 20)
                case .error:
                    VStack(spacing: .zero) {
                        Text("Unable to fetch weather.")
                        
                        Button(action: {
                            Task {
                                try await viewModel.getWeatherData()
                            }
                        })
                            {
                            Text("Retry")
                        }
                            .buttonStyle(.bordered)
                            .padding(.all, 10)
                    }
                    .padding(.vertical, 20)
                }
            }
        }
    }
}

extension CourseInfoView {}

//#Preview {
//    CourseInfoView(viewModel: CourseInfoViewModel(course: CourseModel(course: "Braid Hills",
//                                                                      region: "Edinburgh",
//                                                                      postcode: nil,
//                                                                      coordinates: Coordinates(latitude: 55.9160843, longitude: -3.2045417),
//                                                                      type: .heathland,
//                                                                      yrds: 5865,
//                                                                      holes: 18,
//                                                                      par: nil,
//                                                                      golfshakeRating: nil,
//                                                                      coursePrivate: nil,
//                                                                      courseCourseHC: nil,
//                                                                      courseMyRating: nil,
//                                                                      courseOfficialRating: nil,
//                                                                      costSummer: 150,
//                                                                      costWinter: 55,
//                                                                      courseHC: nil,
//                                                                      myRating: nil,
//                                                                      officialRating: nil,
//                                                                      courseRating: 67.2,
//                                                                      slopeRating: nil), networking: <#any Networking#>)
//}
