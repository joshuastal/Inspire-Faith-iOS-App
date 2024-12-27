//
//  HomeScreen.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/25/24.
//

import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        NavigationView {
            Text("Home Screen")
                .navigationTitle("🏠 Home Screen")
                .toolbar {
                    NavigationLink(destination: SettingsScreen()) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                    }
                }
        }
    }
}

#Preview { HomeScreen() }
