//
//  LoadingCard.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//


import SwiftUI

struct LoadingCard: View {
    @State private var fadeInOut = false
    let height: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray).opacity(0.15)
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.gradient).opacity(fadeInOut ? 0 : 0.15)
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        fadeInOut = !fadeInOut
                    }
                }
            Spacer()
        }.frame(height: height).cornerRadius(10)
    }
}

#Preview {
    LoadingCard(height: 150.0)
}

