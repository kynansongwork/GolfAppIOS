//
//  GameCardView.swift
//  GolfApp
//
//  Created by Kynan Song on 10/10/2024.
//

import SwiftUI

struct GameCardView<ViewModel: GameCardViewModelling>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var gameDate = Date.now
    @State private var selectedCourse: CourseModel?
    
    let isNewGame: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .shadow(radius: 10)
                
                VStack(spacing: 0) {
                    ZStack {
                        VStack(spacing: 0) {
                            HStack(spacing: 20) {

                                NavigationLink(selectedCourseName(), destination: {
                                    CoursesList(selectedCourse: $selectedCourse,
                                                courses: viewModel.courses)
                                })
                                
                                DatePicker("Date", selection: $gameDate)
                            }
                            .padding(.all, 20)
                            Spacer()
                        }
                        
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
                                
                                ForEach(0...setCourseHoles(), id: \.self) { course in
                                    GameCardScoreView(courseHole: course)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .padding(.all, 20)
            
            if isNewGame {
                Button("Save Game") {
                    print("New game saved")
                    //self.viewModel.saveData(courseName: <#T##String#>, date: <#T##Date#>, scores: <#T##Scores#>)
                }
                .padding(.bottom, 20)
            }
        }
 
    }
}

extension GameCardView {
    func selectedCourseName() -> String {
        if let selectedCourse {
            return selectedCourse.course
        } else {
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
                                              context: .init()),
                 isNewGame: false)
}

