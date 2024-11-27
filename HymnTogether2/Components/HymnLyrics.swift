//
//  HymnLyrics.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/25/24.
//

import SwiftUI

struct HymnLyrics: View {
    let lyrics: [[String]]
    
    var body: some View {
        ScrollView {
            HStack {
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
                }
                Spacer()
            }
        }
    }
}

#Preview {
    HymnLyrics(lyrics: [[]])
}
