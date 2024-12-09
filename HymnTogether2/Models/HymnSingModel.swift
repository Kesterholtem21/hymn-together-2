//
//  HymnSingModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation
import CoreLocation

struct PersonMetaModel : Decodable, Encodable {
    var name: String = ""
    var avatar: String = ""
}

struct HymnSingModel : Decodable, Encodable, Identifiable {
    var id: String = ""
    var personId: String = ""
    var name: String = ""
    var description: String = ""
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var date: TimeInterval = TimeInterval()
    var person: PersonMetaModel = PersonMetaModel()
    
    private func degToRad(degrees: Double) -> Double{
        return degrees * .pi/180
    }
    
    var latRads : Double{
        return self.latitude * .pi/180
    }
    
    var longRads : Double{
        return self.longitude * .pi/180
    }
    
    func distance(other: CLLocationCoordinate2D?) -> Double{
        if other == nil{
            return 0.0
        }
        
        let radius = 6371.0
        
        let lat1  = self.latRads
        let lat2 =  other?.latitude
        
        let long1 = self.longRads
        let long2 = other?.longitude
        
        let deltaLat = lat2! - lat1
        let deltaLong = long2! - long1
        
        let distance = 2 * radius * asin(sqrt(pow(sin(deltaLat/2), 2) + cos(lat1)*cos(lat2!)*pow(sin(deltaLong/2), 2)))
        
        return distance
    }
}
