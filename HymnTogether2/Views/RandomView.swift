//
//  ShuffledView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/29/24.
//

import SwiftUI

struct RandomView: View {
    @EnvironmentObject var hymnVM: HymnViewModel
    @EnvironmentObject var audioPlayerVM: AudioPlayerViewModel
    @State var hymn: HymnModel = HymnModel()
    
    var body: some View {
        NavigationStack {
            SelectedHymnView(hymn: hymn)
            .navigationBarItems(
                trailing: HStack(spacing: 10) {
                    Button {
                        self.randomHymn()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }.foregroundStyle(.black)
                    ShareButton(music: hymn.music)
                }
            )
        }.onAppear {
            self.randomHymn()
        }
    }
    
    private func randomHymn() {
        self.hymn = hymnVM.hymns.randomElement()!
        self.audioPlayerVM.pause()
    }
}

#Preview {
    RandomView()
        .environmentObject(HymnViewModel())
        .environmentObject(AudioPlayerViewModel())
        .environmentObject(PersonViewModel())
}
