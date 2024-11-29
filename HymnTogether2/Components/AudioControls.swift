//
//  AudioControls.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/29/24.
//

import SwiftUI

struct AudioControls: View {
    @EnvironmentObject var audioPlayerVM: AudioPlayerViewModel
    
    var body: some View {
        if let hymnPlaying = audioPlayerVM.hymnPlaying {
            if audioPlayerVM.playing {
                Button {
                    audioPlayerVM.pause()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15.0, height: 15.0)
                        Text("Pause").font(.caption).bold()
                    }
                }.foregroundStyle(.black)
            } else {
                Button {
                    audioPlayerVM.play(hymn: hymnPlaying)
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15.0, height: 15.0)
                        Text("Play").font(.caption).bold()
                    }
                }.foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    AudioControls()
        .environmentObject(AudioPlayerViewModel())
}
