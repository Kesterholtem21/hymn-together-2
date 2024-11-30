//
//  SelectedHymnOptions.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import SwiftUI

struct SelectedHymnOptions : View {
    @State var presentLyrics: Bool = false
    @State var presentScore: Bool = false
    @State var presentInfo: Bool = false
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var peopleVM: PeopleViewModel
    let hymn: HymnModel
    let color: Color
    
    var body : some View {
        let savedHymns = personVM.person.savedHymns

        HStack(spacing: 15) {
            Button {
                presentLyrics = true
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "music.microphone").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                    Text("Lyrics").font(.caption)
                }.foregroundStyle(.black)
            }.sheet(isPresented: $presentLyrics) {
                HymnLyrics(hymn: hymn, color: color).padding(20.0)
            }
            if (savedHymns.contains(hymn.id)) {
                Button {
                    personVM.putUnsaveHymn(hymn: hymn)
                    peopleVM.mutatePeople(person: personVM.person)
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "heart.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                        Text("Unsave").font(.caption)
                    }.foregroundStyle(.black)
                }
            } else {
                Button {
                    personVM.putSaveHymn(hymn: hymn)
                    peopleVM.mutatePeople(person: personVM.person)
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "heart").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                        Text("Save").font(.caption)
                    }.foregroundStyle(.black)
                }
            }
            if let score = hymn.score {
                Button {
                    presentScore = true
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "music.note.list").resizable().aspectRatio(contentMode: .fit).frame(width: 20.0, height: 20.0)
                        Text("Score").font(.caption)
                    }.foregroundStyle(.black)
                }.sheet(isPresented: $presentScore) {
                    WebView(url: score).ignoresSafeArea()
                }
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
}

#Preview {
    SelectedHymnOptions(hymn: HymnModel(), color: .blue)
        .environmentObject(PersonViewModel())
}
