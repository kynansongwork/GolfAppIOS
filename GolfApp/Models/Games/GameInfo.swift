//
//  GameInfo.swift
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

struct GameInfo {
    let courseName: String
    let date: Date?
    let id: UUID?
    let par: Int32
    let scores: Scores?
}
