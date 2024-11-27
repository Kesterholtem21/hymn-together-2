//
//  FollowingView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/15/24.
//

import SwiftUI

struct FollowingView: View {
    @State var searchText: String = ""
    @EnvironmentObject var personVM: PersonViewModel
    
    var body: some View {
        let following = personVM.following
        let searchResults: [PersonModel] = following.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        
        NavigationStack {
            if following.isEmpty {
                VStack {
                    Spacer()
                    Text("You are not following anyone")
                    Spacer()
                }.navigationTitle("Following")
                .navigationBarItems(
                    leading: PersonAvatar(person: personVM.person, diameter: 25.0)
                )
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        if (searchResults.isEmpty) {
                            ForEach(0..<following.count, id: \.self) { index in
                                let person = following[index]
                                PersonCard(person: person)
                            }
                        } else {
                            ForEach(0..<searchResults.count, id: \.self) { index in
                                let person = searchResults[index]
                                PersonCard(person: person)
                            }
                        }
                    }
                }.padding(.horizontal)
                .navigationTitle("Following")
                .searchable(text: $searchText)
                .navigationBarItems(
                    leading: PersonAvatar(person: personVM.person, diameter: 25.0)
                )
            }
     }.onAppear {
         personVM.getFollowing()
     }.refreshable {
         personVM.getFollowing()
     }
    }
}

#Preview {
    FollowingView()
        .environmentObject(PersonViewModel())
}
