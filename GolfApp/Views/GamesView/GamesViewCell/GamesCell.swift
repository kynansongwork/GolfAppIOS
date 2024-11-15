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
                    InfoRow(message: "Course:", data: gameInfo.courseName)
                        .multilineTextAlignment(.leading)
                    InfoRow(message: "Score:", data: String(viewModel.totalScore(scores: gameInfo.scores)))
                    InfoRow(message: "Score to par:", data: String(viewModel.calculateScoreToPar(par: gameInfo.par)))
                }
                .padding(.vertical, 20)
                .padding(.trailing, 20)
                
                InfoRow(message: "Date:", data: String(viewModel.formatGameDate(gameInfo.date)))
                    .padding(.top, 20)
            }
            .padding(.horizontal, 20)
        }

    }
}

#Preview {
    GamesCell(gameInfo: GameInfo(courseName: "", date: nil, id: nil, par: 0, scores: nil))
}
