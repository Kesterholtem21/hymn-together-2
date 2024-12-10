//
//  PDFView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/30/24.
//

import SwiftUI

struct PDFView: View {
    let hymn: HymnModel
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 10) {
                Text(hymn.title).font(Font.custom("Georgia", size: 30.0)).bold()
                Text("By \(hymn.author)").font(Font.custom("Georgia", size: 15.0))
            }
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(0..<hymn.lyrics.count, id: \.self) { i in
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(0..<hymn.lyrics[i].count, id: \.self) { j in
                                let verse = hymn.lyrics[i][j]
                                Text(verse).font(Font.custom("Georgia", size: 20.0))
                            }
                        }
                    }
                }
                Spacer()
            }
            HStack(spacing: 0) {
                Text("Powered by ").font(Font.custom("Georgia", size: 15.0))
                Text("HymnTogether").font(Font.custom("Georgia", size: 15.0)).bold()
            }
        }.padding()
    }
}
#Preview {
    PDFView(hymn: HymnModel(title: "Test", author: "test", lyrics: [
        [
            "Beautiful Savior, King of creation,",
            "Son of God and Son of Man!",
            "Truly I'd love Thee, truly I'd serve Thee,",
            "Light of my soul, my Joy, my Crown."
        ],
        [
            "Fair are the meadows, Fair are the woodlands,",
            "Robed in flow'rs of blooming spring;",
            "Jesus is fairer, Jesus is purer;",
            "He makes our sorr'wing spirit sing."
        ],
        [
            "Fair is the sunshine, Fair is the moonlight,",
            "Bright the sparkling stars on high;",
            "Jesus shines brighter, Jesus shines purer",
            "Than all the angels in the sky."
        ],
        [
            "Beautiful Savior, Lord of the nations,",
            "Son of God and Son of Man!",
            "Glory and honor, Praise, adoration,",
            "Now and forevermore be Thine!"
        ]
    ]))
}
