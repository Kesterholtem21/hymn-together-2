//
//  ShareButton.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/28/24.
//

import SwiftUI

struct ShareButton: View {
    let hymn: HymnModel
    var body: some View {
        ShareLink(item: URL(string: hymn.score)!) {
            Image(systemName: "square.and.arrow.up").foregroundStyle(.black)
        }
    }
}

#Preview {
    ShareButton(hymn: HymnModel())
}
