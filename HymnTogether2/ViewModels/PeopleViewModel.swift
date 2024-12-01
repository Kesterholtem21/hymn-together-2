//
//  PeopleViewModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation


class PeopleViewModel : ObservableObject {
    @Published var people: [PersonModel] = [PersonModel]()
    @Published var loading: Bool = false
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
    }
    
    func getPeople() {
        self.loading = true
        Task {
            let people = await BackendService.getPeople()
            await delay()
            await MainActor.run {
                self.people = people
                self.loading = false
            }
        }
    }
    
    func getPerson(id: String) -> PersonModel {
        let filteredPeople = self.people.filter {
            $0.id == id
        }
        return filteredPeople.first!
    }
    
    func mutatePeople(person: PersonModel) {
        var newPeople = self.people.filter {
            $0.id != person.id
        }
        newPeople.append(person)
        self.people = newPeople
    }
}
