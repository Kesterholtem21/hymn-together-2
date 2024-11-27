//
//  PeopleCard.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct PersonCard: View {
    let person: PersonModel
    
    var body: some View {
        NavigationLink {
            SelectedPersonView(person: person)
        } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.gray).opacity(0.1)
                    HStack {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: 10) {
                                PersonAvatar(person: person, diameter: 50.0)
                                Text(person.name).bold().font(.title2)
                            }
                        }
                        Spacer()
                        Text("\(person.followers) \(person.followers == 1 ? "Follower" : "Followers")")
                    }.padding().foregroundColor(.black)
                }.cornerRadius(10)
        }
    }
}

#Preview {
    PersonCard(person: PersonModel(name: "Name", bio: "Bio", followers: 5))
}
