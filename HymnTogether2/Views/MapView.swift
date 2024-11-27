//
//  MapView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let coordinates: [MKAnnotation]
    let region: MKCoordinateRegion
    let enableScroll: Bool
    
    init (hymnSing: HymnSingModel, enableScroll: Bool) {
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: hymnSing.latitude, longitude: hymnSing.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.015))
        self.enableScroll = enableScroll
        self.coordinates = {
            var locs = [MKPointAnnotation]()
            var loc = MKPointAnnotation()
            
            loc = MKPointAnnotation()
            
            loc.coordinate = CLLocationCoordinate2D(latitude: hymnSing.latitude, longitude: hymnSing.longitude)
            loc.title = hymnSing.name
            locs.append(loc)
            return locs
        }()
    }
    
    // How to create this view
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.isScrollEnabled = self.enableScroll
        return map
    }
    
    // How to update the view given the user's various actions?
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // first clear
        uiView.addAnnotations(self.coordinates) // add annotations
        uiView.setRegion(region, animated: true)
    }

    // How to tear down the view
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}


#Preview {
    return MapView(hymnSing: HymnSingModel(), enableScroll: true)
        .ignoresSafeArea()
}
