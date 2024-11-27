//
//  Spinner.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
        HStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
            Text("Loading...")
        }
    }
}

#Preview {
    Spinner()
}
