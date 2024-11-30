//
//  HymnSingModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation
import CoreLocation

struct HymnSingModel : Decodable, Encodable, Identifiable {
    var id: String = ""
    var personId: String = ""
    var name: String = ""
    var lead: String = ""
    var description: String = ""
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    private func degToRad(degrees: Double) -> Double{
        return degrees * .pi/180
    }
    
    func distance(otherLat : Double, otherLong: Double) -> Double{
        let radius = 6371.0
        
        let lat1  = degToRad(degrees: self.latitude)
        let lat2 =  degToRad(degrees: otherLat)
        
        let long1 = degToRad(degrees: self.longitude)
        let long2 = degToRad(degrees: otherLong)
        
        let deltaLat = lat2 - lat1
        let deltaLong = long2 - long1
        
        let distance = 2 * radius * asin(sqrt(pow(sin(deltaLat/2), 2) + cos(lat1)*cos(lat2)*pow(sin(deltaLong/2), 2)))
        
        return distance
    }
}
