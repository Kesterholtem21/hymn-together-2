//
//  LoadingView.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("HymnTogether").font(Font.custom("Georgia", size: 35.0)).bold()
            Spinner()
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
