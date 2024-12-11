//
//  HymnSingCard.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/14/24.
//

import SwiftUI

struct HymnSingCard: View {
    let hymnSing: HymnSingModel
    @State var time: Double = 1731620435.0
    
    func timeLeft() -> String {
        let timeInterval = TimeInterval(time) - Date().timeIntervalSince1970
        let days = Int(timeInterval) / 86400
        let hours = (Int(timeInterval) % 86400) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        return "\(days)d \(hours)h \(minutes)m \(seconds)s"
    }
    
    var body: some View {
        NavigationLink {
            SelectedHymnSingView(hymnSing: hymnSing)
        } label: {
            VStack {
                ZStack {
                    Color(.gray).opacity(0.1)
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(hymnSing.name).font(.title3).bold()
                                Text(hymnSing.description)
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                            Text(" \(self.timeLeft())").onReceive(Timer.publish(every: 1.0, on: .main, in: RunLoop.Mode.common).autoconnect()) {
                                _ in self.time -= 1
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .foregroundColor(.black)
                }
            }.cornerRadius(10.0).onAppear {
                self.time = hymnSing.date
            }
        }
    }
}

#Preview {
    HymnSingCard(hymnSing: HymnSingModel())
}
