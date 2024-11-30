//
//  HymnViewModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation


class HymnViewModel : ObservableObject {
    @Published var hymns: [HymnModel] = [HymnModel]()
    @Published var popularHymns: [PopularHymnModel] = [PopularHymnModel]()
    @Published var randomHymns: [HymnModel] = [HymnModel]()
    
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
    
    func getPopularHymns(people: [PersonModel]) {
        var hymnIds = Set<Int>()
        var savedHymns: [Int: Int] = [:]
        people.forEach { person in
            person.savedHymns.forEach { hymnId in
                if let count = savedHymns[hymnId] {
                    savedHymns[hymnId] = count + 1
                } else {
                    savedHymns[hymnId] = 1
                }
            }
        }
        let popularHymns = hymns.map { hymn in
            PopularHymnModel(hymn: hymn, saves: savedHymns[hymn.id] ?? 0)
        }.sorted { $0.saves > $1.saves }
        self.popularHymns = popularHymns
    }
    
    func getRandomHymns() {
        let shuffled = self.hymns.shuffled()
        self.randomHymns = Array(shuffled.prefix(5))
    }
}
