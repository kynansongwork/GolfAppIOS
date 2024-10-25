//
//  GameCardView.swift
//  GolfApp
//
//  Created by Kynan Song on 10/10/2024.
//

import SwiftUI

struct GameCardView<ViewModel: GameCardViewModelling>: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var gameDate = Date.now
    @State private var selectedCourse: CourseModel?
    @State private var scoreModel = GameScoreModel()
    @State private var totalScore: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(radius: 10)
                
                VStack(spacing: 0) {
                    ZStack {
                        VStack(spacing: .zero) {
                            HStack(spacing: 20) {

                                NavigationLink(selectedCourseName(), destination: {
                                    CoursesList(selectedCourse: $selectedCourse,
                                                courses: viewModel.courses)
                                })
                                
                                DatePicker("", selection: $gameDate)
                                //TODO: Change from HStack to Vstack if title too long?
                            }
                            .padding(.all, 20)
                            Spacer()
                        }
                        
                        VStack(spacing: 20) {
                            
                            Text("Course Par: \(selectedCourse?.par ?? 0)")
                            
                            ScrollView(.horizontal) {
                                HStack(alignment: .center, spacing: 0) {
                                    
                                    VStack(alignment: .center, spacing: 10) {
                                        Text("Hole")
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.mint)
                                        Text("Par")
                                        Text("Score")
                                    }
                                    
                                    ForEach(0...setCourseHoles(), id: \.self) { hole in
                                        GameCardScoreView(courseHole: hole,
                                                          viewModel: scoreModel)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            Text("Your total score is: \(totalScore)")
                        }
                    }
                }
            }
            .padding(.all, 20)
            
            Button(viewModel.gameData != nil ? "Update Game" : "Save Game") {

                if let gameData = viewModel.gameData {
                    print("Editing game \(gameData)")
                } else {
                    self.viewModel.saveData(courseName: selectedCourseName(),
                                            date: gameDate,
                                            scores: Scores(scores: [Score(hole: 1,
                                                                          par: 2,
                                                                          score: totalScore)]),
                                            par: Int32(selectedCourse?.par ?? 0))
                }
                
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.bottom, 20)
        }
        .onReceive(scoreModel.scores) { newScores in
            totalScore = newScores.reduce(0) { $0 + $1.score }
        }
    }
}

extension GameCardView {
    func selectedCourseName() -> String {
        if let selectedCourse {
            return selectedCourse.course
        } else {
            if let gameData = viewModel.gameData {
                return gameData.course ?? "No Course found"
            }
            
            return "Select a course"
        }
    }
    
    func setCourseHoles() -> Int {
        if let index = viewModel.courses.firstIndex(where: { $0.course == selectedCourseName() }) {
            return viewModel.courses[index].holes ?? 0
        }
        
        return 0
    }
}

#Preview {
    GameCardView(viewModel: GameCardViewModel(manager: .init(),
                                              context: .init(),
                                              gameData: nil))
}

