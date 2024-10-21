//
//  Score.swift
//  GolfApp
//
//  Created by Kynan Song on 12/10/2024.
//

import Foundation

public class Score: NSObject, Codable {
    public var hole: Int = 0
    public var par: Int = 0
    public var score: Int = 0
    
    enum Key: String {
        case hole = "hole"
        case par = "par"
        case score = "score"
    }
    
    init(hole: Int, par: Int, score: Int) {
        self.hole = hole
        self.par = par
        self.score = score
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(hole, forKey: Key.hole.rawValue)
        aCoder.encode(par, forKey: Key.par.rawValue)
        aCoder.encode(score, forKey: Key.score.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let hole = aDecoder.decodeInteger(forKey: Key.hole.rawValue)
        let par = aDecoder.decodeInteger(forKey: Key.par.rawValue)
        let score = aDecoder.decodeInteger(forKey: Key.score.rawValue)
        
        self.init(hole: hole, par: par, score: score)
    }
}
