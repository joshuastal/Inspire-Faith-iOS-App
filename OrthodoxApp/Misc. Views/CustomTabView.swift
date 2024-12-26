//
//  CustomTabView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/25/24.
//
import SwiftUI

struct CustomTabView: View {
    @Binding var currentTab: Int
    var tab1: String
    var tab2: String
    
    var body: some View {
        HStack(spacing: 0) {
            TabButton(text: tab1, isSelected: currentTab == 0) {
                currentTab = 0
            }
            
            TabButton(text: tab2, isSelected: currentTab == 1) {
                currentTab = 1
            }
        }
        .padding(4)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
    }
}

struct TabButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .fontWeight(.medium)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color(.systemBackground) : .clear)
                .foregroundColor(isSelected ? .primary : .secondary)
        }
        .buttonStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    CustomTabView(currentTab: .constant(0), tab1: "Tab 1", tab2: "Tab 2")
}
