//
//  SelectedPersonView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct SelectedPersonSavedHymns : View {
    let savedHymns: [HymnModel]
    
    var body : some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(savedHymns) { hymn in
                HymnCard(hymn: hymn)
            }
        }
    }
}

struct SelectedPersonHymnSings : View {
    @EnvironmentObject var personVM: PersonViewModel
    var body : some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(personVM.hymnSings){ hymnSing in
                HymnSingCard(hymnSing: hymnSing).onAppear{
                    print(hymnSing.name)
                }
                
            }
        }
    }
}

struct SelectedPersonView: View {
    @State var isPresented: Bool = false
    @EnvironmentObject var hymnVM: HymnViewModel
    @EnvironmentObject var personVM: PersonViewModel
    @State var selection: Int = 0
    @State var followers: Int = 0
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
                    Text(person.name).font(.title).bold()
                    Spacer()
                }
                if !person.bio.isEmpty {
                    Text(person.bio)
                }
                VStack {
                    Picker("Selection", selection: $selection) {
                        Text("Saved Hymns").tag(0)
                        Text("Hymn Sings").tag(1)
                    }.pickerStyle(.segmented)
                }
                if selection == 0 {
                    SelectedPersonSavedHymns(savedHymns: savedHymns)
                } else if selection == 1 {
                    SelectedPersonHymnSings()
                }
            }
        }.padding(.horizontal)
    }
}

#Preview {
    return SelectedPersonView(person: PersonModel())
        .environmentObject(HymnViewModel())
        .environmentObject(PersonViewModel())
}
