//
//  HomePill.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/2/25.
//

import SwiftUI

struct HomePill: View {
    let iconName: String
    let content: String
    var iconOffset: CGPoint? = nil
    var textOffset: CGPoint? = nil  // Added text offset
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.accentColor)
                .offset(x: iconOffset?.x ?? 0, y: iconOffset?.y ?? 0)
            Text(content)
                .font(.headline)
                .offset(x: textOffset?.x ?? 0, y: textOffset?.y ?? 0)  // Apply text offset
            Spacer()
            
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
        )
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

#Preview {
    HomePill(
        iconName: "testtube.2", content: "Test"
    )
}
