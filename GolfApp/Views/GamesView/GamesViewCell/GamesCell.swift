//
//  GamesViewCell.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct GamesCell: View {
    
    let gameInfo: GameInfo
    let viewModel = GamesCellViewModel()
    
    var body: some View {
        
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 10)
            HStack(alignment: .top, spacing: .zero) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Course: \(gameInfo.courseName)")
                        .multilineTextAlignment(.leading)
                    Text("Score: \(viewModel.totalScore(scores: gameInfo.scores))")
                    Text("Score to par: \(viewModel.calculateScoreToPar(par: gameInfo.par))")
                }
                .padding(.vertical, 20)
                .padding(.trailing, 20)
                
                Text("Date: \(viewModel.formatGameDate(gameInfo.date))")
                    .padding(.top, 20)
            }
            .padding(.horizontal, 20)
        }

    }
}

#Preview {
    GamesCell(gameInfo: GameInfo(courseName: "", date: nil, id: nil, par: 0, scores: nil))
}
