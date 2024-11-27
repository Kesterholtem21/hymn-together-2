//
//  SelectedHymnView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI
import AVFoundation
import AVFAudio

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}

struct SelectedHymnView: View {
    let hymn: HymnModel
    let lyrics: String
    let color: Color
    
    @State var opacity = 0.2
    @State var play: Bool = false
    @StateObject private var soundManager = SoundManager()
    
    var body: some View {
        ZStack {
            Rectangle().fill(color.gradient).opacity(opacity)
                .transition(.opacity) // Optional transition
                .animation(.easeInOut(duration: 1.0), value: opacity) // Smooth fade animation
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Button {
                        soundManager.playSound(sound: hymn.music)
                        play.toggle()
                        
                        if play {
                            soundManager.audioPlayer?.play()
                            withAnimation {
                                opacity = 0.35
                            }
                        } else {
                            soundManager.audioPlayer?.pause()
                            withAnimation {
                                opacity = 0.2
                            }
                        }
                    } label: {
                        ZStack {
                            Rectangle().fill(color.gradient)
                            Text(lyrics)
                                .font(Font.custom("Georgia", size: 30))
                                .foregroundColor(.black)
                                .fixedSize(horizontal: false, vertical: true)
                                .rotationEffect(Angle(degrees: 15), anchor: .center)
                                .opacity(0.2).frame(width: 350)
                            
                            Image(systemName: play ? "pause.fill" : "play.fill").resizable().frame(width: 35.0, height: 35.0).foregroundColor(.white)
                        }.frame(width: 250, height: 250.0).clipped().cornerRadius(16.0)
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text(hymn.title).font(.title).bold().multilineTextAlignment(.center)
                            .frame(width: 300)
                            Text(hymn.author)
                    }
                    SelectedHymnOptions(hymn: hymn, color: color)

                }
                Spacer()
            }

        }
        .ignoresSafeArea()
    }
}

#Preview {
    SelectedHymnView(hymn: HymnModel(title: "Testing", author: "test"), lyrics: "Lyrics", color: .blue)
        .environmentObject(PersonViewModel())
}
