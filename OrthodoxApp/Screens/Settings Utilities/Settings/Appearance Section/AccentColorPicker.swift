//
//  ExtractedView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//
import SwiftUI
import Foundation

struct AccentColorPicker: View {
    
    @Binding var accentColor: Color
    
    var body: some View {
        HStack {
            Text("Accent Color")
            Spacer()
            ColorPicker("", selection: $accentColor)
                .labelsHidden()
        }
    }
}
