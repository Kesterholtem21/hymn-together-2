//
//  ShareButton.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/28/24.
//

import SwiftUI

struct ShareButton: View {
    let music: String
    var body: some View {
        ShareLink(item: URL(string: music)!) {
            Image(systemName: "square.and.arrow.up").foregroundStyle(.black)
        }
    }
}

#Preview {
    ShareButton(music: "https://google.com")
}
