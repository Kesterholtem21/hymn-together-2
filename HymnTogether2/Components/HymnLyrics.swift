//
//  HymnLyrics.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/25/24.
//

import SwiftUI

struct HymnLyrics: View {
    let lyrics: [[String]]
    let color: Color
    
    var body: some View {
            HStack {
                ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Lyrics").font(.title2).bold()
                    ForEach(0..<lyrics.count, id: \.self) { i in
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(0..<lyrics[i].count, id: \.self) { j in
                                let verse = lyrics[i][j]
                                Text(verse)
                            }
                        }
                    }
                    Button {
                        // TODO: Print lyrics view
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0).fill(color)
                            HStack {
                                Image(systemName: "printer")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25.0, height: 25.0)
                                Text("Print Lyrics")
                            }.padding().foregroundStyle(.white)
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HymnLyrics(lyrics: [[]], color: .blue)
}
