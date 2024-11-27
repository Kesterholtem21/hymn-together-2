//
//  PersonViewModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation

class PersonViewModel : ObservableObject {
    @Published var person: PersonModel = PersonModel()
    @Published var hymnSings: [HymnSingModel] = [HymnSingModel]()
    @Published var loading: Bool = false
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
    }
    
    func getPerson(id: String) {
        self.loading = true
        Task {
            let person = await BackendService.getPerson(id: id)
            await delay()
            await MainActor.run {
                self.person = person
                self.loading = false
            }
        }
    }
    
    func postPerson(person: PersonModel) {
        Task {
            let personReturned = await BackendService.postPerson(person: person)
            await MainActor.run {
                self.person = personReturned
            }
        }
    }
    
    func putSaveHymn(hymn: HymnModel) {
        let id = hymn.id
        person.savedHymns.append(id)
        self.person = person
        Task {
            await BackendService.putPerson(person: person)
            await MainActor.run {
                self.person = person
            }
        }
    }
    
    func putUnsaveHymn(hymn: HymnModel) {
        let id = hymn.id
        person.savedHymns.removeAll(where: { $0 == id })
        self.person = person
        Task {
            await BackendService.putPerson(person: person)
            await MainActor.run {
                self.person = person
            }
        }
    }
}
