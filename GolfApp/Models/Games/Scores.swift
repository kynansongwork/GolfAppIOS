//
//  Scores.swift
//  GolfApp
//
//  Created by Kynan Song on 12/10/2024.
//

import Foundation

public class Scores: NSObject, Codable {
    public var scores: [Score] = []
    
    enum Key: String, CodingKey {
        case scores = "scores"
    }
    
    init(scores: [Score]) {
        self.scores = scores
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(scores, forKey: Key.scores.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        if let scores = aDecoder.decodeObject(forKey: Key.scores.rawValue) as? [Score] {
            self.init(scores: scores)
        }
        
        self.init(scores: [])
    }
}
