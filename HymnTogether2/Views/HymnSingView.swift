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
        let hymnSingRef = hymnSingVM.currentLocation
        let hymnSings = hymnSingVM.hymnSings.sorted{(hymn1, hymn2) in
            let distance1 = hymn1.distance(other:hymnSingRef)
            let distance2 = hymn2.distance(other:hymnSingRef)
            
            return distance1 < distance2
        }
        
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
