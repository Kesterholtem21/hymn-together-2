//
//  HymnSingViewModel.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import Foundation


class HymnSingViewModel : ObservableObject {
    @Published var loading: Bool = false
    @Published var hymnSings: [HymnSingModel] = [HymnSingModel]()
    @Published var personHymnSings: [HymnSingModel] = [HymnSingModel]()
    
    func getHymnSings() {
        self.loading = true
        Task {
            let hymnSings = await BackendService.getHymnSings()
            await MainActor.run {
                self.hymnSings = hymnSings
                self.loading = false
            }
        }
    }
    
    func postHymnSing(hymnSing: HymnSingModel) {
        Task {
            await BackendService.postHymnSing(hymnSing: hymnSing)
        }
    }
    
    func getPersonHymnSings(person: PersonModel) {
        self.loading = true
        Task {
            let personHymnSings = await BackendService.getPersonHymnSings(person: person)
            await MainActor.run {
                self.personHymnSings = personHymnSings
                self.loading = false
            }
        }
    }
    
    func mutateHymnSings(hymnSing: HymnSingModel) {
        self.hymnSings.append(hymnSing)
        self.hymnSings = hymnSings
    }
    
    func mutatePersonHymnSings(hymnSing: HymnSingModel) {
        self.personHymnSings.append(hymnSing)
        self.personHymnSings = personHymnSings
    }
}
