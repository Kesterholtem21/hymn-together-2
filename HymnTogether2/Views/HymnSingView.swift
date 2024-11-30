//
//  HymnSingView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct HymnSingView: View {
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var hymnSingVM: HymnSingViewModel
    @State var searchText: String = ""
    @State var presentAdd: Bool = false
    
    var body: some View {
        let hymnSings = hymnSingVM.hymnSings.sorted(
            by:{
            $0.distance(otherLat: hymnSingVM.currentLocation?.latitude ?? 0, otherLong: hymnSingVM.currentLocation?.longitude ?? 0)
            <
            $1.distance(otherLat: hymnSingVM.currentLocation?.latitude ?? 0, otherLong: hymnSingVM.currentLocation?.longitude ?? 0)
        })
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    if hymnSings.count > 0 {
                        ForEach(hymnSings){sing in
                            HymnSingCard(hymnSing: sing)
                        }
                    }
                }.padding(.horizontal)
            }
            .navigationTitle("Hymn Sings")
            .searchable(text: $searchText)
            .navigationBarItems(
                leading: PersonAvatar(person: personVM.person, diameter: 25.0),
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
        .environmentObject(AudioPlayerViewModel())
        .environmentObject(HymnSingViewModel())
}
