//
//  HomePill.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/2/25.
//

import SwiftUI

struct DefaultContentPill: View {
    let iconName: String
    let content: String
    var iconOffset: CGPoint? = nil
    var textOffset: CGPoint? = nil  // Added text offset
    var scalesText: Bool = false
    var lineLimit: Int = 2
    var maxWidth: CGFloat? = nil  // Add optional max width parameter
    @AppStorage("accentColor") private var accentColor: Color = .blue

    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .frame(width: 24, height: 24)  // Force consistent icon frame
                .foregroundColor(accentColor)
                .offset(x: iconOffset?.x ?? 0, y: iconOffset?.y ?? 0)
            
            Text(content)
                .font(.headline)
                .modifier(ScalingTextModifier(scales: scalesText, lineLimit: lineLimit))
                .offset(x: textOffset?.x ?? 0, y: textOffset?.y ?? 0)  // Apply text offset
            
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .frame(maxWidth: maxWidth ?? .infinity) // Use maxWidth if provided
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
        )
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}


// Create a custom modifier for the scaling text
struct ScalingTextModifier: ViewModifier {
    let scales: Bool
    var lineLimit: Int = 2
    
    func body(content: Content) -> some View {
        if scales {
            content
                .minimumScaleFactor(0.85)
                .lineLimit(lineLimit)
                .fixedSize(horizontal: false, vertical: true)
        } else {
            content
        }
    }
}
