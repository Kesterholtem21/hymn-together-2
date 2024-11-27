//
//  PersonViewModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation

class PersonViewModel : ObservableObject {
    @Published var person: PersonModel = PersonModel()
    @Published var following: [PersonModel] = [PersonModel]()
    @Published var hymnSings: [HymnSingModel] = [HymnSingModel]()
    
    func getPerson(id: String) {
        Task {
            let person = await BackendService.getPerson(id: id)
            await MainActor.run {
                self.person = person
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
        }
    }
    
    func putUnsaveHymn(hymn: HymnModel) {
        let id = hymn.id
        person.savedHymns.removeAll(where: { $0 == id })
        self.person = person
        Task {
            await BackendService.putPerson(person: person)
        }
    }
    
    func getFollowing() {
        let following = self.person.following
        Task {
            let people = await BackendService.getPeople()
            let filterPeople = people.filter {
                following.contains($0.id)
            }
            await MainActor.run {
                self.following = filterPeople
            }
        }
    }
    
    func getHymnSings() {
        Task {
            let hymnSigns = await BackendService.getPersonHymnSings(person: person)
            await MainActor.run {
                self.hymnSings = hymnSigns
            }
        }
    }
}
