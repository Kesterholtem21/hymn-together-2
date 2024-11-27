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
    @State var presentLyrics: Bool = false
    @State var presentScore: Bool = false
    @State var presentInfo: Bool = false
    @State var play: Bool = false
    @StateObject private var soundManager = SoundManager()
    @EnvironmentObject var personVM: PersonViewModel

    var body: some View {
        let savedHymns = personVM.person.savedHymns
        
        ZStack {
            Rectangle().fill(color.gradient).opacity(0.3)
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Button {
                        soundManager.playSound(sound: hymn.music)
                        play.toggle()
                        
                        if play {
                            soundManager.audioPlayer?.play()
                        } else {
                            soundManager.audioPlayer?.pause()
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
                    VStack(spacing: 10) {
                        Text(hymn.title).font(.title).bold().multilineTextAlignment(.center)
                            .frame(width: 300)
                        Text(hymn.author)
                    }
                    HStack(spacing: 15) {
                        Button {
                            presentLyrics = true
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "music.microphone").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                                Text("Lyrics").font(.caption)
                            }.foregroundStyle(.black)
                        }.sheet(isPresented: $presentLyrics) {
                            HymnLyrics(lyrics: hymn.lyrics).padding(20.0)
                        }
                        if (savedHymns.contains(hymn.id)) {
                            Button {
                                personVM.putUnsaveHymn(hymn: hymn)
                            } label: {
                                VStack(spacing: 10) {
                                    Image(systemName: "heart.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                                    Text("Unsave").font(.caption)
                                }.foregroundStyle(.black)
                            }
                        } else {
                            Button {
                                personVM.putSaveHymn(hymn: hymn)
                            } label: {
                                VStack(spacing: 10) {
                                    Image(systemName: "heart").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                                    Text("Save").font(.caption)
                                }.foregroundStyle(.black)
                            }
                        }
                        Button {
                            presentScore = true
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "music.note.list").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                                Text("Score").font(.caption)
                            }.foregroundStyle(.black)
                        }.sheet(isPresented: $presentScore) {
                            WebView(url: hymn.score).ignoresSafeArea()
                        }
                        Button {
                            presentInfo = true
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "info").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                                Text("Info").font(.caption)
                            }.foregroundStyle(.black)
                        }.sheet(isPresented: $presentInfo) {
                            let wikipediaPage = hymn.title.replacingOccurrences(of: " ", with: "_")
                            WebView(url: "https://en.wikipedia.com/wiki/\(wikipediaPage)")
                        }
                    }
                }
                Spacer()
            }

        }.ignoresSafeArea()
    }
    }

#Preview {
    SelectedHymnView(hymn: HymnModel(), lyrics: "Lyrics", color: .blue)
        .environmentObject(PersonViewModel())
}
