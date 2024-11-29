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
        let searchResults: [PersonModel] = peopleVM.people.filter {
            $0.name.lowercased().contains(searchTerm.lowercased())
        }
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    if (searchResults.isEmpty) {
                        ForEach(0..<peopleVM.people.count, id: \.self) { index in
                            let person = peopleVM.people[index]
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
                leading: PersonAvatar(person: personVM.person, diameter: 15.0),
                trailing: AudioControls()
            )
            .navigationTitle("People")
        }
        
    }
}

#Preview {
    PeopleView()
        .environmentObject(PeopleViewModel())
        .environmentObject(PersonViewModel())
        .environmentObject(AudioPlayerViewModel())
}
