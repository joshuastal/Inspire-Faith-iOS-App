//
//  AppearanceSection.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//
import SwiftUI
import Foundation

struct AppearanceSection: View {
    
    @Binding var selectedTheme: String
    @Binding var quoteFontSize: Double
    @Binding var readingFontSize: Double
    @Binding var accentColor: Color
    
    var body: some View {
        Section(header: Text("Appearance")) {
            
            ThemeSelector(selectedTheme: $selectedTheme)
            
            
            AccentColorPicker(accentColor: $accentColor)
            
            
            QuoteCardFontSize(quoteFontSize: $quoteFontSize)
            
            
            ReadingsFontSize(readingFontSize: $readingFontSize)
        }
    }
}
