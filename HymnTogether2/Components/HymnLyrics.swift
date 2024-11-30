//
//  HymnLyrics.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/25/24.
//

import SwiftUI


@MainActor
func render(lyrics: [[String]], color: Color) -> String{
    let renderer = ImageRenderer(content:
            ForEach(0..<lyrics.count, id: \.self) { i in
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(0..<lyrics[i].count, id: \.self) { j in
                        let verse = lyrics[i][j]
                        Text(verse)
                    }
                }
            }
        )
    
    let url = URL.documentsDirectory.appending(path: "output.pdf")
    
    renderer.render{ size, context in
        var box = CGRect(x:0,y:0, width:size.width, height:size.height)
        
        guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else{
            return
        }
        
        pdf.beginPDFPage(nil)
        context(pdf)
        pdf.endPDFPage()
        pdf.closePDF()
    }
    
    let urlString = url.absoluteString
    return urlString
    

    
    
    
    


}




struct HymnLyrics: View {
    @State var presentLyrics: Bool = false
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
//                    Button {
//                        // TODO: Print lyrics view
//                        //ShareLink("Export PDF", item: render(lyrics: lyrics, color: color))
//                        //WebView(url: render(lyrics: lyrics, color: color))
//                        //render(lyrics: lyrics, color: color)
//                        //presentLyrics = true
//                        
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10.0).fill(color)
//                            HStack {
//                                Image(systemName: "printer")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 25.0, height: 25.0)
//                                Text("Print Lyrics")
//                            }.padding().foregroundStyle(.white)
//                        }.fixedSize(horizontal: false, vertical: true)
//                    }
//                   .sheet(isPresented: $presentLyrics){
//                      WebView(url: render(lyrics: lyrics, color: color))
//                }
                    ShareLink("Export PDF", item: render(lyrics: lyrics, color: color))
                }
                Spacer()
            }
        }
        
    }
}

#Preview {
    HymnLyrics(lyrics: [[]], color: .blue)
}
