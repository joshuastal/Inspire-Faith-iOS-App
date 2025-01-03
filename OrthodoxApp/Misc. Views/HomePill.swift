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
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.accentColor)
            Text(content)
                .font(.headline)
            Spacer()
            
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(maxWidth: .infinity) // Add this to match card width
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
                )
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.horizontal) // Match the card's horizontal padding
    }
}

#Preview {
    HomePill(
        iconName: "testtube.2", content: "Test"
    )
}
