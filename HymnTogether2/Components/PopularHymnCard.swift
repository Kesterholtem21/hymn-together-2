//
//  PopularHymnCard.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//


import SwiftUI

struct PopularHymnCard: View {
    let popularHymn: PopularHymnModel
    
    var body: some View {
        let hymn = popularHymn.hymn
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
                        HStack(alignment: .bottom, spacing: 10) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                            Text("\(popularHymn.saves)")
                                .frame(height: 15)
                        }
                    }.padding().foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading) // Aligns text to the left

                    Spacer()
                }
            }.frame(height: 150.0).cornerRadius(16.0)
        }
    }
}

#Preview {
    PopularHymnCard(popularHymn: PopularHymnModel(hymn: HymnModel(), saves: 0))
}
