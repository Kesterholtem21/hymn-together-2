import SwiftUI

struct HymnCard: View {
    let hymn: HymnModel
    
    var body: some View {
        // Define an array of colors to rotate through
        let colors = [Color.red, Color.orange, Color.blue, Color.green]
        // Select color based on the hymn's ID and the array index
        let color = colors[hymn.id % colors.count]
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
                            .opacity(0.2).frame(width: 250)
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
    HymnCard(hymn: HymnModel())
}
