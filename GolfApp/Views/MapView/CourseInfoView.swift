//
//  CourseInfoView.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI
import CoreLocation

struct CourseInfoView: View {
    
    let course: CourseModel
    
    var body: some View {
        ZStack() {
            VStack(spacing: 0) {
                Text(course.course)
                    .font(.title)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                    .padding(.horizontal, 20)
                Text(course.region)
                    .font(.subheadline)
                Text(course.postcode ?? "Closed")
                    .font(.subheadline)
                Spacer()
            }
            
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    Text("**Rating:** \(course.courseRating?.toString(to: 2) ?? 0.toString(to: 2))")
                    Text("**Holes:** \(course.holes ?? 0)")
                }
                
                HStack(spacing: 8) {
                    Text("**Size:** \(course.yrds) yards")
                    Text("**Type:** \(course.type.rawValue.capitalized)")
                }
                
                
                if let summerCost = course.costSummer {
                    Text("**Cost summer:** £\(summerCost)")
                } else {
                    Text("Closed").bold()
                }
                
                if let winterCost = course.costWinter {
                    Text("Cost winter: £\(winterCost)")
                }
                
                //Show weather?
            }
        }

    }
}

extension CourseInfoView {}

#Preview {
    CourseInfoView(course: CourseModel(course: "Braid Hills",
                                       region: "Edinburgh",
                                       postcode: nil,
                                       coordinates: Coordinates(latitude: 55.9160843, longitude: -3.2045417),
                                       type: .heathland,
                                       yrds: 5865,
                                       holes: 18,
                                       par: nil,
                                       golfshakeRating: nil,
                                       coursePrivate: nil,
                                       courseCourseHC: nil,
                                       courseMyRating: nil,
                                       courseOfficialRating: nil,
                                       costSummer: 150,
                                       costWinter: 55,
                                       courseHC: nil,
                                       myRating: nil,
                                       officialRating: nil,
                                       courseRating: 67.2,
                                       slopeRating: nil))
}
