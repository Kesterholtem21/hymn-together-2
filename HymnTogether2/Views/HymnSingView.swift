//
//  HymnSingView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct HymnSingView: View {
    @EnvironmentObject var personVM: PersonViewModel
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    HymnSingCard(hymnSing: HymnSingModel(
                        name: "Test",
                        lead: "Lead", description: "Description", email: "Liam.j.grossman@gmail.com"))
                    HymnSingCard(hymnSing: HymnSingModel(
                        name: "Test",
                        lead: "Lead", description: "Description", email: "Liam.j.grossman@gmail.com"))
                    HymnSingCard(hymnSing: HymnSingModel(
                        name: "Test",
                        lead: "Lead", description: "Description", email: "Liam.j.grossman@gmail.com"))

                }.padding(.bottom)
            }.padding(.horizontal)
                .navigationTitle("Hymn Sings")
                .searchable(text: $searchText)
                .navigationBarItems(
                    leading: PersonAvatar(person: personVM.person, diameter: 25.0),
                    trailing: HStack(spacing: 15) {
                        Image(systemName: "map")
                        Image(systemName: "plus")
                    }
                )
            
        }
    }
}

#Preview {
    HymnSingView()
        .environmentObject(PersonViewModel())
}
