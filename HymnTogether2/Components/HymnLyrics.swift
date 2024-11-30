//
//  HymnLyrics.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/25/24.
//

import SwiftUI


@MainActor
func render(hymn: HymnModel) -> URL {
    let renderer = ImageRenderer(content: PDFView(hymn: hymn))
    
    let url = URL.documentsDirectory.appending(path: "\(hymn.title).pdf")
    
    renderer.render { size, context in
        var box = CGRect(x:0,y:0, width:size.width, height:size.height)
        
        guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else{
            return
        }
        
        pdf.beginPDFPage(nil)
        context(pdf)
        pdf.endPDFPage()
        pdf.closePDF()
    }
    
    return url
}




struct HymnLyrics: View {
    @State var presentLyrics: Bool = false
    let hymn: HymnModel
    let color: Color
    
    var body: some View {
            HStack {
                ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Lyrics").font(.title2).bold()
                    ForEach(0..<hymn.lyrics.count, id: \.self) { i in
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(0..<hymn.lyrics[i].count, id: \.self) { j in
                                let verse = hymn.lyrics[i][j]
                                Text(verse)
                            }
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0).fill(color)
                        ShareLink("Export PDF", item: render(hymn: hymn)).padding().foregroundStyle(.white)
                    }.fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
        }
        
    }
}

#Preview {
    HymnLyrics(hymn: HymnModel(), color: .blue)
}
