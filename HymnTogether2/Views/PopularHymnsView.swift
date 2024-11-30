//
//  PopularHymnsView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import SwiftUI

struct PopularHymnsView: View {
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var hymnVM: HymnViewModel
    @EnvironmentObject var peopleVM: PeopleViewModel
    @State var searchTerm: String = ""
    
    var body: some View {
        let popularHymns = hymnVM.getPopularHymns(people: peopleVM.people)
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(popularHymns) { popularHymn in
                        PopularHymnCard(popularHymn: popularHymn)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Popular Hymns")
            .searchable(text: $searchTerm).cornerRadius(16.0)
            .navigationTitle("Hymns")
            .navigationBarItems(
                leading: PersonAvatar(person: personVM.person, diameter: 20.0),
                trailing: AudioControls()

            )
        }
    }
}

#Preview {
    PopularHymnsView()
        .environmentObject(PersonViewModel())
        .environmentObject(HymnViewModel())
        .environmentObject(PeopleViewModel())
        .environmentObject(AudioPlayerViewModel())
}
