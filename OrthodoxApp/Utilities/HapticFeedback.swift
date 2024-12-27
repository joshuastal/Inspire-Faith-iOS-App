//
//  HapticFeedback.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//

import SwiftUI

extension View {
    func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare() // Reduces latency by preparing the generator
        generator.impactOccurred()
    }
    
    // You might want to add other haptic-related functions here in the future
    func selectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}
