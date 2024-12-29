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
    @AppStorage("quoteFontSize") private var quoteFontSize: Double = 18
    @AppStorage("readingFontSize") private var readingFontSize: Double = 19
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    
    @State private var showingAbout = false
    @State private var showingPrivacyPolicy = false
    @State private var showingDatePicker = false
    
    @StateObject private var notificationSettings = NotificationSettings()
    
    var body: some View {
        List {
            
            AppearanceSection (
                selectedTheme: $selectedTheme,
                quoteFontSize: $quoteFontSize,
                readingFontSize: $readingFontSize,
                accentColor: $accentColor
            )
            
            NotificationSection (
                notificationSettings: notificationSettings,
                showingDatePicker: $showingDatePicker
            )
            
            AboutSection (
                showingAbout: $showingAbout,
                showingPrivacyPolicy: $showingPrivacyPolicy
            )
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
        .sheet(isPresented: $showingDatePicker) {
            NotificationTimePicker(
                notificationSettings: notificationSettings,
                isPresented: $showingDatePicker
            )
        }
    }
}

#Preview { SettingsScreen() }











