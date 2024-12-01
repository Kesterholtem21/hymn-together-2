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
                            AsyncImage(url: URL(string: person.avatar)) { result in
                                result.image?
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .cornerRadius(.infinity)
                            }.frame(width: 50.0, height: 50.0)
                            Text(person.name).bold().font(.title2)
                        }
                    }
                    Spacer()
                }.padding().foregroundColor(.black)
            }.cornerRadius(10).fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    PersonCard(person: PersonModel(name: "Name", bio: "Bio"))
}
