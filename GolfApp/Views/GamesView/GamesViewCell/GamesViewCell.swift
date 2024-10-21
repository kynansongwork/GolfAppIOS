//
//  GamesViewCell.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct GamesViewCell: View {
    
    let courseName: String
    let date: Date = Date.now
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 10)
            HStack(spacing: 0) {
                Text(courseName)
                    .padding(.all, 10)
                Text("Date: \(date)")
                    .padding(.all, 10)
            }
        }

    }
}

#Preview {
    GamesViewCell(courseName: "Test")
}
