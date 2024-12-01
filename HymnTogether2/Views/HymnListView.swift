//
//  HymnListView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct HymnListView: View {
    @EnvironmentObject var hymnVM: HymnViewModel
    @EnvironmentObject var personVM: PersonViewModel
    @State var searchTerm: String = ""
    
    var body: some View {
        let hymns: [HymnModel] = hymnVM.hymns
        let searchResults: [HymnModel] = hymns.filter {
            $0.author.lowercased().contains(searchTerm.lowercased()) ||
            $0.title.lowercased().contains(searchTerm.lowercased())
        }
        
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if (searchResults.count > 0) {
                        ForEach(searchResults) { hymn in
                            HymnCard(hymn: hymn)
                        }
                    } else {
                        ForEach(hymnVM.hymns) { hymn in
                            HymnCard(hymn: hymn)
                        }
                    }
                }.padding(.bottom).padding(.horizontal)
            }
            .searchable(text: $searchTerm).cornerRadius(16.0)
            .navigationTitle("Hymns")
            .navigationBarItems(
                leading: PersonAvatar(person: personVM.person, diameter: 25.0),
                trailing: AudioControls()
            )
        }
    }
}

#Preview {
    HymnListView()
        .environmentObject(HymnViewModel())
        .environmentObject(PersonViewModel())
        .environmentObject(AudioPlayerViewModel())
}
