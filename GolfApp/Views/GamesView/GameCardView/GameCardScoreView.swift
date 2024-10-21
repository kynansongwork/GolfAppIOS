//
//  GameCardScore.swift
//  GolfApp
//
//  Created by Kynan Song on 10/10/2024.
//

import SwiftUI

struct GameCardScoreView: View {
    @State var score: String = ""
    @State var par: String = ""
    let courseHole: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("\(courseHole)")
                .frame(maxWidth: .infinity)
                .background(Color.mint)
            
            Group {
                TextField("0", text: $par.max(2))
                    .frame(width: 40)
                    .keyboardType(.numberPad)
                TextField("0", text: $score.max(2))
                    .frame(width: 40)
                    .keyboardType(.numberPad)
            }
            .padding(.leading, 30)
        }
    }
}

#Preview {
    GameCardScoreView(courseHole: 1)
}
