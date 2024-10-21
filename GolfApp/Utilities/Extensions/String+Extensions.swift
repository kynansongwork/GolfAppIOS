//
//  String+Extensions.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//


extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
