//
//  HymnSingViewModel.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import Foundation
import CoreLocation

class HymnSingViewModel : NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var loading: Bool = false
    @Published var hymnSings: [HymnSingModel] = [HymnSingModel]()
    @Published var personHymnSings: [HymnSingModel] = [HymnSingModel]()
    
    var locationManager = CLLocationManager() // create a location manager to request permission from user
    @Published var currentLocation : CLLocationCoordinate2D? = nil // save user's current location
    
    override init(){
        super.init()
        locationManager.delegate = self
    }
    
    func getHymnSings() {
        self.loading = true
        Task {
            let hymnSings = await BackendService.getHymnSings()
            await MainActor.run {
                self.hymnSings = hymnSings
                self.loading = false
            }
        }
    }
    
    func postHymnSing(hymnSing: HymnSingModel) {
        Task {
            await BackendService.postHymnSing(hymnSing: hymnSing)
        }
    }
    
    func getPersonHymnSings(id: String) {
        self.loading = true
        Task {
            let personHymnSings = await BackendService.getPersonHymnSings(id: id)
            await MainActor.run {
                self.personHymnSings = personHymnSings
                self.loading = false
            }
        }
    }
    
    func mutateHymnSings(hymnSing: HymnSingModel) {
        self.hymnSings.append(hymnSing)
        self.hymnSings = hymnSings
    }
    
    func mutatePersonHymnSings(hymnSing: HymnSingModel) {
        self.personHymnSings.append(hymnSing)
        self.personHymnSings = personHymnSings
    }
    
    func getUserLocation(){
        // Check if we have the permission
        if locationManager.authorizationStatus == .authorizedWhenInUse{
            currentLocation = nil
            locationManager.requestLocation()
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // detect if user allowed, then request location
        if manager.authorizationStatus == .authorizedWhenInUse{
            currentLocation = nil
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations.first?.coordinate
        // print(locations.last?.coordinate)
        if currentLocation == nil {
            currentLocation = locations.last?.coordinate
        }
        locationManager.stopUpdatingLocation() // needs it once
    }
}
