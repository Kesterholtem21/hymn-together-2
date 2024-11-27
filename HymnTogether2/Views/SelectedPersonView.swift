//
//  SelectedPersonView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct SelectedPersonView: View {
    @State var isPresented: Bool = false
    @EnvironmentObject var hymnVM: HymnViewModel
    @EnvironmentObject var personVM: PersonViewModel
    @State var followers = 0
    let person: PersonModel
    
    var body: some View {
        let hymns: [HymnModel] = hymnVM.hymns
        let savedHymns = hymns.filter {
            person.savedHymns.contains($0.id)
        }
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 15) {
                    AsyncImage(url: URL(string: person.avatar))
                        .frame(width: 70.0, height: 70.0)
                        .cornerRadius(.infinity)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(person.name).font(.title).bold()
                        HStack(spacing: 10) {
                            Text("\(followers) \(followers == 1 ? "Follower" : "Followers")")
                            if person.id != personVM.person.id {
                                FollowButton(followers: $followers, person: person)
                            }
                        }
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text("Bio").font(.title2).bold()
                    Text(person.bio)
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text("Saved Hymns").font(.title2).bold()
                    ForEach(0..<savedHymns.count, id: \.self) { index in
                        let hymn = savedHymns[index]
                        HymnCard(hymn: hymn)
                    }
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text("Hymn Sings").font(.title2).bold()
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            self.followers = person.followers
        }
    }
}

#Preview {
    return SelectedPersonView(person: PersonModel())
        .environmentObject(HymnViewModel())
        .environmentObject(PersonViewModel())
}
