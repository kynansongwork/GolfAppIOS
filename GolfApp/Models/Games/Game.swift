//
//  Game.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import Foundation

struct ScoreTest {
    let hole: Int
    let par: Int
    let score: Int
}

struct GameTest: Identifiable {
    var id = UUID()
    let course: String
    let date: Date
    let scores: [ScoreTest]
}
