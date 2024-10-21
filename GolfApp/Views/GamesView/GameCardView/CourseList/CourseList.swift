//
//  CourseList.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import SwiftUI

struct CoursesList: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedCourse: CourseModel?
    let courses: [CourseModel]
    
    
    var body: some View {
        List(courses) { course in
            CourseRow(course: course, isSelected: course == selectedCourse)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCourse = course
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

//#Preview {
//    CourseList(courses: [], selectedCourse: nil)
//}
