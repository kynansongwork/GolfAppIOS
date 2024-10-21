//
//  CourseList.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct CoursesList: View {
    
    let courses: [CourseModel]
    
    var body: some View {
        List {
            ForEach(courses) { course in
                HStack(spacing: 0) {
                    Text(course.course)
                    Spacer()
                    Text(course.region)
                }
            }
        }

    }
}

#Preview {
    CoursesList(courses: [])
}
