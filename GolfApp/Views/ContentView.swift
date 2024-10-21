//
//  ContentView.swift
//  GolfApp
//
//  Created by Kynan Song on 02/10/2024.
//

import SwiftUI

enum Tab : String, Hashable {
    case courses, games, profile
}

struct ContentView: View {
    @AppStorage("tab") var tab = Tab.courses
    @AppStorage("name") var name = "Skipper"
    @State var appearance = ""
    @State var isBeating = false
    
    var body: some View {
        TabView {
            CoursesMapView(viewModel: CoursesMapViewModel(), position: .automatic)
                .tabItem {
                    Label("Find Courses", systemImage: "mappin.and.ellipse")
                }
            
            NavigationStack {
                GamesView()
                    .background(Color.white)
            }
            .padding(.bottom, 1)
            .tabItem {
                Label("Game Tracker", systemImage: "table")
            }
            .tag(Tab.games)
            
            NavigationStack {
                Form {
                    TextField("Name", text: $name)
                    Picker("Appearance", selection: $appearance) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    HStack {
                        Text(verbatim: "💙")
                        Text("Powered by SwiftUI")
                    }
                    .foregroundStyle(.gray)
                }
                .navigationTitle("Profile")
            }
            .padding(.bottom, 1)
            .tabItem {
                Label("Profile", systemImage: "person")
            }
            .tag(Tab.profile)
        }
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

#Preview {
    ContentView()
}
