//
//  ThemeSelector.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//
import SwiftUI
import Foundation

struct ThemeSelector: View {
    
    @Binding var selectedTheme: String
    
    var body: some View {
        Picker("Theme", selection: $selectedTheme) {
            ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                Text(theme.rawValue)
                    .tag(theme.rawValue)
                    .foregroundStyle(.secondary)
            }
        }
        .tint(.secondary)
    }
}
