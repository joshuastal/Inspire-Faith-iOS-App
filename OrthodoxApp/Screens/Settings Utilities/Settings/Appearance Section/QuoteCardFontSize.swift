//
//  FontSizeSelector.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//

import SwiftUI
import Foundation

struct QuoteCardFontSize: View {
    
    @Binding var quoteFontSize: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Quote Font Size")
                Spacer()
                Text("\(Int(quoteFontSize))")
                    .foregroundColor(.secondary)
            }
            
            Slider(value: $quoteFontSize, in: 14...24, step: 1) {
                Text("Font Size")
            }
        }
    }
}
