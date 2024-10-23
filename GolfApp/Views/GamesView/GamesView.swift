//
//  GamesView.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct GamesView<ViewModel: GamesViewModelling>: View {
    
    @EnvironmentObject var manager: DatabaseManager
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var viewModel: ViewModel
    
    @FetchRequest(sortDescriptors: []) private var games: FetchedResults<Game>
    
    @State private var addGamePressed = false
    
    var body: some View {
        
        //TODO: List will show game cards. Need to add an add button which will bring up the card view and allow the user to edit and save.
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    ForEach(games, id: \.self) { i in
                        NavigationLink(destination: {
                            GameCardView(viewModel: GameCardViewModel(manager: manager,
                                                                      context: viewContext),
                                         gameData: i)
                            .padding(.all, 20)
                            
                            //TODO: Add swipe to delete.
                        }) {
                            GamesCell(gameInfo: viewModel.mapGameInfo(game: i))
                                .padding(.all, 10)
                        }
                    }
                }
        
                addGameButton()
                    .padding(.bottom, 8)
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Game Tracker")
        }
        .navigationDestination(isPresented: $addGamePressed) {
            GameCardView(viewModel: GameCardViewModel(manager: manager,
                                                      context: viewContext),
                                                     gameData: nil)
        }
    }
}

extension GamesView {
    
    private func addGameCard() {
        print("Add pressed")
        addGamePressed = true
    }
    
    private func addGameButton() -> some View {
        Button(action: addGameCard) {
            HStack(spacing: 4) {
                Image(systemName: "plus")
                Text("Add game")
            }
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
        }
        //TODO: Use button styles here.
        .font(.headline)
        .foregroundColor(.white)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

#Preview {
    GamesView(viewModel: GamesViewModel())
}

