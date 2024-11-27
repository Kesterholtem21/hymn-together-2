//
//  HymnSingModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation
import CommonCrypto

struct HymnSingModel : Decodable, Encodable, Identifiable {
    var id: String = ""
    var personId: String = ""
    var name: String = ""
    var lead: String = ""
    var description: String = ""
    var longitude: Double = 0.0
    var latitude: Double = 0.0
}
