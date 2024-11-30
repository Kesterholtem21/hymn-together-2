//
//  SelectedHymnView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct SelectedHymnView: View {
    let hymn: HymnModel
    
    @State var opacity = 0.2
    @EnvironmentObject var audioPlayerVM: AudioPlayerViewModel
    
    var body: some View {
        let playing = audioPlayerVM.playing && audioPlayerVM.hymnPlaying?.id == hymn.id
        // Define an array of colors to rotate through
        let colors = [Color.red, Color.orange, Color.blue, Color.green]
        // Select color based on the hymn's ID and the array index
        let color = colors[hymn.id % colors.count]
        let lyrics = hymn.lyrics.flatMap { $0 }.joined(separator: " ")
        
        ZStack {
            Rectangle().fill(color.gradient).opacity(opacity)
                .transition(.opacity) // Optional transition
                .animation(.easeInOut(duration: 1.0), value: opacity) // Smooth fade animation
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Button {
                        if playing {
                            audioPlayerVM.pause()
                            withAnimation {
                                opacity = 0.2
                            }
                        } else {
                            audioPlayerVM.play(hymn: hymn)
                            withAnimation {
                                opacity = 0.5
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
                            
                            Image(systemName: playing ? "pause.fill" : "play.fill").resizable().frame(width: 35.0, height: 35.0).foregroundColor(.white)
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
        .onAppear {
            opacity = audioPlayerVM.playing && audioPlayerVM.hymnPlaying?.id == hymn.id ? 0.5 : 0.2
        }
    }
}

#Preview {
    SelectedHymnView(hymn:  HymnModel(title: "Testing", author: "test", music: "https://google.com"))
        .environmentObject(PersonViewModel())
        .environmentObject(AudioPlayerViewModel())
}
