//
//  View+Extensions.swift
//  GolfApp
//
//  Created by Kynan Song on 15/11/2024.
//

import SwiftUI

extension View {
    func InfoRow(message: String, data: String) -> some View {
        HStack(alignment: .top, spacing: 4) {
            Text(message)
                .bold()
            Text(data)
                .multilineTextAlignment(.leading)
        }
    }
}
