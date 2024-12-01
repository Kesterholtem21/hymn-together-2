//
//  ShuffledView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/29/24.
//

import SwiftUI

struct RandomView: View {
    @EnvironmentObject var hymnVM: HymnViewModel
    @EnvironmentObject var personVM: PersonViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(hymnVM.randomHymns) { hymn in
                        HymnCard(hymn: hymn)
                    }
                }.padding(.bottom).padding(.horizontal)
            }
            .navigationTitle("Random")
            .navigationBarItems(
                leading: PersonAvatar(person: personVM.person, diameter: 25.0),
                trailing: AudioControls()
            )
        }.onAppear {
            hymnVM.getRandomHymns()
        }.refreshable {
            hymnVM.getRandomHymns()
        }
    }
}

#Preview {
    RandomView()
        .environmentObject(HymnViewModel())
        .environmentObject(AudioPlayerViewModel())
        .environmentObject(PersonViewModel())
}
