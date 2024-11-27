//
//  HymnCard.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct HymnCard: View {
    let hymn: HymnModel
    
    var body: some View {
        let color = hymn.id % 4 == 0 ? Color.green : hymn.id % 3 == 0 ? Color.blue : hymn.id % 2 == 0 ? Color.orange : Color.red
        let lyrics = hymn.lyrics.flatMap { $0 }.joined(separator: " ")
        
        NavigationLink {
            SelectedHymnView(hymn: hymn, lyrics: lyrics, color: color)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.gray).opacity(0.1)
                HStack {
                    ZStack {
                        Rectangle().fill(color.gradient).frame(width: 150.0, height: 150.0)
                        Text(lyrics)
                            .font(Font.custom("Georgia", size: 30))
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                            .rotationEffect(Angle(degrees: 15), anchor: .center)
                            .opacity(0.2).frame(width: 200.0)
                            .clipped()
                    }.frame(width: 150.0).clipped()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(hymn.title)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text(hymn.author)
                            .multilineTextAlignment(.leading)
                    }.padding().foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading) // Aligns text to the left

                    Spacer()
                }
            }.frame(height: 150.0).cornerRadius(16.0)
        }
    }
}

#Preview {
    HymnCard(hymn: HymnModel(title: "Test"))
}
