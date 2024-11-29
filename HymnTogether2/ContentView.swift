//
//  ContentView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("id") var id: String = ""
    @State var needsOnboarding: Bool = false
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var hymnSingVM: HymnSingViewModel
    @EnvironmentObject var peopleVM: PeopleViewModel

    var body: some View {
        ZStack {
            if personVM.loading || peopleVM.loading || hymnSingVM.loading {
                LoadingView()
            } else {
                TabView {
                    HymnListView().tabItem {
                        VStack {
                            Image(systemName: "music.note")
                            Text("Hymns")
                        }
                    }
                    PopularHymnsView().tabItem {
                        VStack {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            Text("Popular")
                        }
                    }
                    RandomView().tabItem {
                        VStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Random")
                        }
                    }
                    HymnSingView().tabItem {
                        VStack {
                            Image(systemName: "music.note.house")
                            Text("Hymn Sings")
                        }
                    }
                    PeopleView().tabItem {
                        VStack {
                            Image(systemName: "person.fill")
                            Text("People")
                        }
                    }
                }.fullScreenCover(isPresented: $needsOnboarding) {
                    OnboardingView()
                }.tint(.black)
            }
        }.onAppear {
            if !id.isEmpty {
                personVM.getPerson(id: id)
                peopleVM.getPeople()
                hymnSingVM.getHymnSings()
                hymnSingVM.getPersonHymnSings(id: id)
            } else {
                needsOnboarding = true
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HymnViewModel())
        .environmentObject(PeopleViewModel())
        .environmentObject(HymnSingViewModel())
        .environmentObject(PersonViewModel())
        .environmentObject(AudioPlayerViewModel())
}
