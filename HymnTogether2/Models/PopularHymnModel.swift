//
//  PopularHymnModel.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import Foundation

struct PopularHymnModel : Identifiable {
    var id: UUID = UUID()
    var hymn: HymnModel
    var saves: Int = 0
    
    init(hymn: HymnModel, saves: Int) {
        self.hymn = hymn
        self.saves = saves
    }
}
