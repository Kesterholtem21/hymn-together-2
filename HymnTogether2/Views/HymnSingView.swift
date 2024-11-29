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
    @State var presentAdd: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    HymnSingCard(hymnSing: HymnSingModel(
                        name: "Test",
                        lead: "Lead", description: "Description"))
                    HymnSingCard(hymnSing: HymnSingModel(
                        name: "Test",
                        lead: "Lead", description: "Description"))
                    HymnSingCard(hymnSing: HymnSingModel(
                        name: "Test",
                        lead: "Lead", description: "Description"))

                }.padding(.bottom)
            }.padding(.horizontal)
                .navigationTitle("Hymn Sings")
                .searchable(text: $searchText)
                .navigationBarItems(
                    leading: PersonAvatar(person: personVM.person, diameter: 15.0),
                    trailing:
                        HStack(spacing: 10) {
                            NavigationLink {
                                AddHymnSingView()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15.0, height: 15.0)
                                    .foregroundStyle(.black)
                            }
                            AudioControls()
                        }
                )
        }
    }
}

#Preview {
    HymnSingView()
        .environmentObject(PersonViewModel())
        .environmentObject(HymnViewModel())
}
