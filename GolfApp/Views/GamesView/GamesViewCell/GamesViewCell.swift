//
//  GamesViewCell.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct GamesViewCell: View {
    
    let gameInfo: GameInfo
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 10)
            HStack(spacing: 0) {
                Text(gameInfo.courseName)
                    .padding(.all, 10)
                Text("Date: \(gameInfo.date)")
                    .padding(.all, 10)
            }
        }

    }
}

#Preview {
    GamesViewCell(gameInfo: GameInfo(courseName: "", date: nil, id: nil, scores: nil))
}
