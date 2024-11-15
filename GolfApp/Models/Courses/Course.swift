//
//  Course.swift
//  GolfApp
//
//  Created by Kynan Song on 02/10/2024.
//

import Foundation
import MapKit

import Foundation
import MapKit

struct Coordinates: Decodable {
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
    }
}

enum CourseType: String, Decodable {
    case parkland = "Parkland"
    case heathland = "Heathland"
    case links = "Links"
    case moorland = "Moorland"
    case mixed = "Mixed"
}

struct CourseModel: Identifiable, Equatable, Decodable {
    static func == (lhs: CourseModel, rhs: CourseModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    let course: String
    let region: String
    let postcode: String?
    let coordinates: Coordinates
    let type: CourseType
    let yrds: Int
    let holes, par: Int?
    let golfshakeRating: Double?
    let coursePrivate: Bool?
    let courseCourseHC: Double?
    let courseMyRating, courseOfficialRating, costSummer, costWinter: Int?
    let courseHC: Double?
    let myRating, officialRating: Double?
    let courseRating: Double?
    let slopeRating: Int?
    let website: String?
    
    enum CodingKeys: String, CodingKey {
        case course = "COURSE"
        case region = "REGION"
        case postcode = "POSTCODE"
        case coordinates = "Coordinates"
        case type = "TYPE"
        case yrds = "YRDS"
        case holes = "HOLES"
        case par = "PAR"
        case golfshakeRating
        case coursePrivate = "Private"
        case courseCourseHC = "courseHC"
        case courseMyRating = "myRating"
        case courseOfficialRating = "OfficialRating"
        case costSummer
        case costWinter = "CostWinter"
        case courseHC = "Course HC"
        case myRating = "My Rating"
        case officialRating = "Official Rating"
        case courseRating = "courseRating"
        case slopeRating = "slopeRating"
        case website = "website"
    }
}
