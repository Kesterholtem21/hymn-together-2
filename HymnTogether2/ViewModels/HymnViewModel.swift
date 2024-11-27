//
//  HymnViewModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation


class HymnViewModel : ObservableObject {
    @Published var hymns: [HymnModel] = [HymnModel]()
    
    init() {
        readJSON()
    }

    func readJSON() {
        let pathString = Bundle.main.path(forResource: "data", ofType: "json")
        
        if let path = pathString {
            let url = URL(fileURLWithPath: path)

            do {
                let data = try Data(contentsOf: url)
                let json_decoder = JSONDecoder()
                let json_data = try json_decoder.decode([HymnModel].self, from: data)
                self.hymns = json_data
            } catch {
                print(error)
            }
        }
    }
    
    func getPersonHymns(person: PersonModel) -> [HymnModel] {
        let filteredHymns = hymns.filter {
            person.savedHymns.contains($0.id)
        }
        return filteredHymns
    }
}
