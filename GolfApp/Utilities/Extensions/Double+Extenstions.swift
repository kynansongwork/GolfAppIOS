//
//  Double+Extenstions.swift
//  GolfApp
//
//  Created by Kynan Song on 07/11/2024.
//

import Foundation

extension Double {
    func toString(to places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
