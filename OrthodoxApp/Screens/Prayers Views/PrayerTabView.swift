//
//  PrayerTabView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 4/14/25.
//

import SwiftUI

struct PrayerTabView: View {
    @Binding var currentTab: Int
    var tabs: [String]
    @Namespace private var animation
    @AppStorage("accentColor") private var accentColor: Color = .blue

    var body: some View {
        ZStack {
            // Overall background capsule
            Capsule()
                .fill(Color.gray.opacity(0.3))
            
            // Underline indicator (blue highlight) layer
            HStack(spacing: 0) {
                ForEach(tabs.indices, id: \.self) { index in
                    if currentTab == index {
                        Capsule()
                            .fill(accentColor.opacity(0.5))
                            .matchedGeometryEffect(id: "tabIndicator", in: animation)
                            .frame(maxWidth: .infinity)
                    } else {
                        Color.clear.frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(4)
            
            // Foreground layer with non-animated text buttons
            HStack(spacing: 0) {
                ForEach(tabs.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            currentTab = index
                        }
                    }) {
                        Text(tabs[index])
                            .foregroundColor(currentTab == index ? .white : .black)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                }
            }
            .padding(4)
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
    }
}

struct PrayerTabButton: View {
    let text: String
    let isSelected: Bool
    var animation: Namespace.ID
    let action: () -> Void
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(isSelected ? .white : .black)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(
                    Capsule()
                        .fill(isSelected ? accentColor.opacity(0.5) : .clear)
                )
        }
    }
}
