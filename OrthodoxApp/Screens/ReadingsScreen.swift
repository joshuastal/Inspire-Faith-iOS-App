//
//  ReadingsScreen.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/25/24.
//

import SwiftUI

struct ReadingsScreen: View {
    var body: some View {
        NavigationView {
            OrthocalView()
                .navigationTitle("📙 Readings")
        }
    }
}

#Preview { ReadingsScreen() }
