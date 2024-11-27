//
//  HymnSingModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation
import CommonCrypto

struct HymnSingModel : Decodable {
    var name: String = ""
    var lead: String = ""
    var description: String = ""
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var email: String = ""
    var emailHash: String {
        guard let data = email.data(using: .utf8) else { return "" }
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        data.withUnsafeBytes { bytes in
            _ = CC_MD5(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
