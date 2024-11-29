//
//  HymnTogether2App.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/26/24.
//

import SwiftUI

@main
struct HymnTogether2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HymnViewModel())
                .environmentObject(PersonViewModel())
                .environmentObject(HymnSingViewModel())
                .environmentObject(PeopleViewModel())
                .environmentObject(AudioPlayerViewModel())
        }
    }
}
