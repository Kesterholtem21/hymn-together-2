//
//  AudioPlayerViewModel.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/29/24.
//

import SwiftUI
import AVFoundation

class AudioPlayerViewModel : ObservableObject {
    @Published var playing: Bool = false
    @Published var hymnPlaying: HymnModel? = nil
    private var audioPlayer: AVPlayer?

    func play(hymn: HymnModel) {
        if hymnPlaying?.id == hymn.id {
            audioPlayer?.play()
        } else {
            // Load and play a new hymn
            if let url = URL(string: hymn.music) {
                self.audioPlayer = AVPlayer(url: url)
                self.audioPlayer?.play()
                self.hymnPlaying = hymn
            }
        }
        self.playing = true
    }
    
    func pause() {
        audioPlayer?.pause()
        playing = false
    }
}
