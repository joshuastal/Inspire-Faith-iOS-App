//
//  DataButtonView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//

import SwiftUI

// MenuButton.swift
struct DataButtonView: View {
    let iconName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                Text(title)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.up")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
    }
}

#Preview {
    DataButtonView(iconName: "testtube.2", title: "Test Title", action: {
        print("Button tapped")
    })
}
