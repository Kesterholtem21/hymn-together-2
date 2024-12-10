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
        let searchResults: [PopularHymnModel] = hymnVM.popularHymns.filter {
            $0.hymn.author.lowercased().contains(searchTerm.lowercased()) ||
            $0.hymn.title.lowercased().contains(searchTerm.lowercased())
        }
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    if (searchResults.count > 0) {
                        ForEach(searchResults) { popularHymn in
                            PopularHymnCard(popularHymn: popularHymn)
                        }
                    } else {
                        ForEach(hymnVM.popularHymns) { popularHymn in
                            PopularHymnCard(popularHymn: popularHymn)
                        }
                    }
                }.padding(.bottom).padding(.horizontal)
            }
            .navigationTitle("Popular Hymns")
            .searchable(text: $searchTerm).cornerRadius(16.0)
            .navigationTitle("Hymns")
            .navigationBarItems(
                leading: PersonAvatar(person: personVM.person, diameter: 25.0),
                trailing: AudioControls()

            )
            .onAppear {
                hymnVM.getPopularHymns(people: peopleVM.people)
            }
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
