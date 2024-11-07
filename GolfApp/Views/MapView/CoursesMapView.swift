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

        ZStack {
            Map(position: $position,
                selection: $selectedCourse) {
                
                // Markers to show courses across Scotland.
                //TODO: Will need filtering.
                ForEach(viewModel.courses) { course in
                    Marker(course.course, coordinate: CLLocationCoordinate2D(
                        latitude: course.coordinates.latitude,
                        longitude: course.coordinates.longitude))
                    .tag(course.course)
                }
                
                //Showing user location
                if viewModel.locationAuthorisation == .authorizedAlways || viewModel.locationAuthorisation == .authorizedWhenInUse {
                    UserAnnotation()
                }
                
            }
            .onAppear {
                viewModel.getLocation()
            }
            .mapStyle(MapStyle.standard(elevation: MapStyle.Elevation.realistic))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .sheet(item: $selectedCourse) { course in
                if let selectedPlace {
                    CourseInfoView(course: selectedPlace)
                        .presentationDetents(.init([.medium]))
                }
            }
            
            VStack(spacing: .zero) {
                Spacer()
                Slider(value: $viewModel.distance,
                       in: 10000...300000,
                       step: 10000,
                       minimumValueLabel: Text("Nearby"),
                       maximumValueLabel: Text("All")
                ) {}
                .padding(.all, 20)
            }

        }
    }
}

