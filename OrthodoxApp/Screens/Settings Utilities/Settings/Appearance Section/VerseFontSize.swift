//
//  ReadingsFontSize.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import SwiftUI

struct VerseFontSize: View {
    
    @Binding var verseFontSize: Double

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Verse Font Size")
                Spacer()
                Text("\(Int(verseFontSize))")
                    .foregroundColor(.secondary)
            }
            
            Slider(value: $verseFontSize, in: 14...24, step: 1) {
                Text("Font Size")
            }
        }
    }
}

