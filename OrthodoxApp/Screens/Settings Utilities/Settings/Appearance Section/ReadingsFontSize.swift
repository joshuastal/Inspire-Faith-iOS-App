//
//  ReadingsFontSize.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import SwiftUI

struct ReadingsFontSize: View {
    
    @Binding var readingFontSize: Double

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Readings Font Size")
                Spacer()
                Text("\(Int(readingFontSize))")
                    .foregroundColor(.secondary)
            }
            
            Slider(value: $readingFontSize, in: 14...24, step: 1) {
                Text("Font Size")
            }
        }
    }
}

