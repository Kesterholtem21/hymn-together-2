//
//  PeopleViewModel.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import Foundation


class PeopleViewModel : ObservableObject {
    @Published var people: [PersonModel] = [PersonModel]()
    
    func getPeople() {
        Task {
            let people = await BackendService.getPeople()
            await MainActor.run {
                self.people = people
            }
        }
    }

    func getFollowing(id: String) {
        Task {
            let person = await BackendService.getPerson(id: id)
            let people = await BackendService.getPeople()
            await MainActor.run {
                self.people = people.filter {
                    person.following.contains($0.id)
                }
            }
        }
    }
}
