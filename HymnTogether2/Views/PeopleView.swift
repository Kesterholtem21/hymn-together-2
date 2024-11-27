//
//  PeopleView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct PeopleView: View {
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var peopleVM: PeopleViewModel
    @State var searchTerm: String = ""

    var body: some View {
        let people = peopleVM.people.filter {
            $0.id != personVM.person.id
        }
        let searchResults: [PersonModel] = people.filter {
            $0.name.lowercased().contains(searchTerm.lowercased())
        }

        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    if (searchResults.isEmpty) {
                        ForEach(0..<people.count, id: \.self) { index in
                            let person = people[index]
                            PersonCard(person: person)
                        }
                    } else {
                        ForEach(0..<searchResults.count, id: \.self) { index in
                            let person = searchResults[index]
                            PersonCard(person: person)
                        }
                    }
                }
            }.padding(.horizontal)
                .searchable(text: $searchTerm)
                .navigationBarItems(
                    leading: PersonAvatar(person: personVM.person, diameter: 25.0)
                )
                .navigationTitle("People")
        }.onAppear {
            peopleVM.getPeople()
        }.refreshable {
            peopleVM.getPeople()
        }
    }
}

#Preview {
    PeopleView()
        .environmentObject(PeopleViewModel())
        .environmentObject(PersonViewModel())
}
