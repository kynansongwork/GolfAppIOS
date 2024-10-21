//
//  CourseListRow.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct CourseRow: View {
    let course: CourseModel
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.course)
                    .font(.headline)
                Text(course.region)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}
