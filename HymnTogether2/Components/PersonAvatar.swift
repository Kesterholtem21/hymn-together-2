//
//  PersonAvatar.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/26/24.
//

import SwiftUI

struct PersonAvatar: View {
    let person: PersonModel
    let diameter: Double
    
    var body: some View {
        NavigationLink {
            SelectedPersonView(person: person)
        } label: {
            AsyncImage(url: URL(string: person.avatar)) { result in
                result.image?
                    .resizable()
                    .frame(width: diameter, height: diameter)
                    .cornerRadius(.infinity)
            }.frame(width: diameter, height: diameter)
        }
    
    }
}

#Preview {
    PersonAvatar(person: PersonModel(), diameter: 20.0)
}
