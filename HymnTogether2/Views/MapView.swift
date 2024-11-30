//
//  MapView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    let hymnSing: HymnSingModel
    let disableScroll: Bool = true
    
    var body : some View {
        Map {
            Marker(hymnSing.name, coordinate: CLLocationCoordinate2D(
                latitude: hymnSing.latitude, longitude: hymnSing.longitude
            ))
        }.disabled(disableScroll)
    }
}


#Preview {
    return MapView(hymnSing: HymnSingModel())
        .ignoresSafeArea()
}
