//
//  GameCardScore.swift
//  GolfApp
//
//  Created by Kynan Song on 10/10/2024.
//

import SwiftUI

struct GameCardScoreView<ViewModel: GameScoreModeling>: View {
    @State var score: String = ""
    @State var par: String = ""
    let courseHole: Int
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("\(courseHole)")
                .frame(maxWidth: .infinity)
                .background(Color.mint)
            
            Group {
                
                TextField("0", text: Binding(get: { par },
                                             set: { newValue in
                    par = String(newValue.prefix(2))
                    viewModel.updateScore(hole: courseHole,
                                          newScore: score,
                                          newPar: par)
                }))
                    
                TextField("0", text: Binding(get: { score },
                                             set: { newValue in
                    let filtered = String(newValue.filter { $0.isNumber }.prefix(2))
                    score = filtered
                    viewModel.updateScore(hole: courseHole,
                                          newScore: filtered,
                                          newPar: par)
                }))
            }
            .frame(width: 40)
            .keyboardType(.numberPad)
            .padding(.leading, 30)
            .onAppear {
                if score != "" {
                    viewModel.updateScore(hole: courseHole,
                                          newScore: score,
                                          newPar: par)
                }
            }
        }
    }
}

//#Preview {
//    GameCardScoreView(courseHole: 1)
//}
