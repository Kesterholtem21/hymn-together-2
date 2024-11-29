//
//  SelectedHymnView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI
import AVFoundation
import AVFAudio
import MediaPlayer

class AudioPlayer : ObservableObject {
    static let shared = AudioPlayer()
    
    var player: AVPlayer?
    
    func play(hymn: HymnModel) {
        let url = URL(string: hymn.music)
        player = AVPlayer(playerItem: AVPlayerItem(url: url!))
        player?.play()
        self.updateNowPlayerInfo(hymn: hymn)
    }
    
    private func updateNowPlayerInfo(hymn: HymnModel) {
        guard let player = player, let currentItem = player.currentItem else { return }
    
        let info: [String: Any] = [
            MPMediaItemPropertyTitle: hymn.title,
            MPMediaItemPropertyArtist: hymn.author,
            MPMediaItemPropertyGenre: "Hymns",
            MPMediaItemPropertyPlaybackDuration: currentItem.duration,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: player.currentTime().seconds,
            MPNowPlayingInfoPropertyPlaybackRate: player.rate
        ]
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
    }
    
    func pause(hymn: HymnModel) {
        player?.pause()
        updateNowPlayerInfo(hymn: hymn)
    }
}

struct SelectedHymnView: View {
    let hymn: HymnModel
    let lyrics: String
    let color: Color
    
    @State var opacity = 0.2
    @State var play: Bool = false
    @ObservedObject var player = AudioPlayer.shared
    
    var body: some View {
        ZStack {
            Rectangle().fill(color.gradient).opacity(opacity)
                .transition(.opacity) // Optional transition
                .animation(.easeInOut(duration: 1.0), value: opacity) // Smooth fade animation
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Button {
                        play.toggle()
                        if play {
                            player.play(hymn: hymn)
                            withAnimation {
                                opacity = 0.35
                            }
                        } else {
                            player.pause(hymn: hymn)
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
        .navigationBarItems(
            trailing: ShareButton(hymn: hymn)
        )
        .onAppear {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                setupRemoteControls()
            } catch {
                print(error)
            }
        }
    }
    
    private func setupRemoteControls() {
        let commands = MPRemoteCommandCenter.shared()
        
        commands.pauseCommand.addTarget { _ in
            player.pause(hymn: hymn)
            return .success
        }
        
        commands.playCommand.addTarget { _ in
            player.play(hymn: hymn)
            return .success
        }
    }
}

#Preview {
    SelectedHymnView(hymn: HymnModel(title: "Testing", author: "test"), lyrics: "Lyrics", color: .blue)
        .environmentObject(PersonViewModel())
}
