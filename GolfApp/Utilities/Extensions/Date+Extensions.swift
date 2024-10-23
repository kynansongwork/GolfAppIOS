//
//  Date+Extensions.swift
//  GolfApp
//
//  Created by Kynan Song on 23/10/2024.
//

import Foundation

enum DateFormats: String {
    case dateAndTime = "E, d MMM yyyy HH:mm:ss"
    case date = "MMM d, yyyy"
    case time = "HH:mm:ss"
    
}

extension Date {
   func getFormattedDate(format: DateFormats) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format.rawValue
        return dateformat.string(from: self)
    }
}
