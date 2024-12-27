//
//  SettingsScreen.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/26/24.
//

import SwiftUI

import SafariServices

struct SettingsScreen: View {
    
    @AppStorage("appTheme") private var selectedTheme: String = AppTheme.system.rawValue
    @AppStorage("quoteFontSize") private var quoteFontSize: Double = 18 // Add this line
    
    
    @State private var showingAbout = false
    @State private var showingPrivacyPolicy = false // Add this state variable
    
    
    var body: some View {
        List {
            
            Section(header: Text("Appearance")) {
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                        Text(theme.rawValue).tag(theme.rawValue)
                    }
                }
                
                
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
            
            Section(header: Text("About")) {
                Button("About") {
                    showingAbout.toggle()
                }
                .foregroundStyle(.white)
                
                
                Button("Privacy Policy") {
                    showingPrivacyPolicy.toggle()
                }
                .foregroundStyle(.white)
            }
        }
        .navigationTitle("⚙ Settings")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
        .sheet(isPresented: $showingPrivacyPolicy) {
            SafariView(url: URL(string: "https://doc-hosting.flycricket.io/ios-inspire-faith-privacy-policy/eaa9ce4c-4489-47a6-8d71-35bb9e9d7742/privacy")!)
                .ignoresSafeArea()
        }
    }
}

#Preview { SettingsScreen() }
