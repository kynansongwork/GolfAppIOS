//
//  MapView.swift
//  GolfApp
//
//  Created by Kynan Song on 02/10/2024.
//

import SwiftUI
import MapKit

struct CoursesMapView<ViewModel: CoursesMapViewModelling>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var position: MapCameraPosition = .automatic
    @State var selectedCourse: String?
    
    private var selectedPlace: CourseModel? {
        if let selectedCourse {
            return viewModel.courses.first(where: { $0.course == selectedCourse })
        }
        return nil
    }
    
    var body: some View {
        Map(position: $position, selection: $selectedCourse) {
            
            ForEach(viewModel.courses) { course in
                Marker(course.course, coordinate: CLLocationCoordinate2D(latitude: course.coordinates.latitude,
                                                                       longitude: course.coordinates.longitude))
                .tag(course.course)
            }
            
        }
        .mapStyle(MapStyle.standard(elevation: MapStyle.Elevation.realistic))
        .mapControls {
            MapUserLocationButton()
        }
        .sheet(item: $selectedCourse) { course in
            if let selectedPlace {
                CourseInfoView(course: selectedPlace)
                    .presentationDetents(.init([.medium]))
            }
        }
    }
}

#Preview {
    let previewModel = CoursesMapViewModel()
    if #available(iOS 17.0, *) {
        CoursesMapView(viewModel: previewModel)
    } else {
        // Fallback on earlier versions
    }
}
