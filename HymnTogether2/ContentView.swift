//
//  ContentView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    @AppStorage("id") var id: String = ""
    @EnvironmentObject var personVM: PersonViewModel
    
    var body: some View {
        @State var needsOnboarding = id.isEmpty
        
        TabView(selection: $selection) {
            HymnListView().tabItem {
                VStack {
                    Image(systemName: "music.note")
                    Text("Hymns")
                }
            }.tag(1)
            HymnSingView().tabItem {
                VStack {
                    Image(systemName: "music.note.house")
                    Text("Hymn Sings")
                }
            }.tag(2)
            PeopleView().tabItem {
                VStack {
                    Image(systemName: "person.fill")
                    Text("People")
                }
            }.tag(4)
            FollowingView().tabItem {
                VStack {
                    Image(systemName: "person.3.fill")
                    Text("Following")
                }
            }.tag(5)
        }.fullScreenCover(isPresented: $needsOnboarding) {
            needsOnboarding = false
        } content: {
            OnboardingView()
        }.onAppear {
            if (!needsOnboarding) {
                personVM.getPerson(id: id)
            }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
        .environmentObject(HymnViewModel())
        .environmentObject(PeopleViewModel())
        .environmentObject(PersonViewModel())
}
