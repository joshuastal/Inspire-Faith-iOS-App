//
//  HomeScreen.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/25/24.
//

import SwiftUI
import UserNotifications
import FirebaseCore
import FirebaseFirestore

struct HomeScreen: View {
    let db = Firestore.firestore()
    @ObservedObject var quotesViewModel: QuotesViewModel
    @ObservedObject var orthocalViewModel: OrthocalViewModel  // Add this for calendar data
    @State private var isNotificationsDenied = false
    
    var fastLevel: String? {
        orthocalViewModel.calendarDay?.fastLevelDesc
    }
    
    // Add a computed property for the title logic
    var fastTitle: String {
        guard let level = fastLevel else { return "" }
        
        // Multiple conditions with a switch
        switch level {
        case "No Fast":
            return "🍽️"
        case
            "Fast — Wine and Oil are Allowed",
            "Lenten Fast — Wine and Oil are Allowed",
            "Nativity Fast — Wine and Oil are Allowed",
            "Apostles Fast — Wine and Oil are Allowed",
            "Dormition Fast — Wine and Oil are Allowed"
        :
            return "🍷 🫒"
        case
            "Fast — Fish, Wine and Oil are Allowed",
            "Lenten Fast — Fish, Wine and Oil are Allowed",
            "Lenten Fast — Wine, Oil and Caviar are Allowed",
            "Nativity Fast — Fish, Wine and Oil are Allowed",
            "Apostles Fast — Fish, Wine and Oil are Allowed",
            "Dormition Fast — Fish, Wine and Oil are Allowed"
        :
            return "🐟 🍷 🫒"
        case "Fast — Meat Fast":
            return "🧀 🐟 🍷 🫒"
        case
            "Fast",
            "Lenten Fast — No overrides",
            "Lenten Fast",
            "Nativity Fast",
            "Dormition Fast"
        :
            return "🥬 🥕 🍎"
        case
            "Lenten Fast — Strict Fast",
            "Nativity Fast — Strict Fast",
            "Apostles Fast"
        :
            return "🚫"
        default:
            return "Fast \(level)"
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 16) {
                    
                    HStack (spacing: 8) {
                        
                        // Fasting Block
                        if orthocalViewModel.calendarDay != nil {
                            HomePill(
                                iconName: "fork.knife",
                                content: "Fast: \(fastTitle)"
                            )
                            .padding(.leading, 8)
                        }
                        
                        // Tone Block
                        if let tone = orthocalViewModel.calendarDay?.tone {
                            HomePill (
                                iconName: "music.note",
                                content: "Tone: \(tone)",
                                iconOffset: CGPoint(x: -5, y: 0),
                                textOffset: CGPoint(x: -6, y: 0),
                                maxWidth: 150
                            )
                            .padding(.trailing, 8)
                        }
                    }
                    
                    
                    if let feasts = orthocalViewModel.calendarDay?.feasts, !feasts.isEmpty {
                        HomePill(
                            iconName: "party.popper",
                            content: "Feasts: \(feasts.joined(separator: ", \n"))",
                            iconOffset: CGPoint(x: -10, y: 0),
                            textOffset: CGPoint(x: -11, y: 0),
                            scalesText: true
                        ).padding(.horizontal, 8)
                    }
                    
                    
                    
                    DailyQuoteCardView(
                        quote: quotesViewModel.dailyQuote ?? quotesViewModel.testQuote,
                        viewModel: quotesViewModel
                    )
                    
                    DailyVerseView()
                    
                    Spacer()
                }
            }
            .task {
                
                quotesViewModel.updateDailyQuote()
                
                //checkNotificationStatusAndSchedule(
                //    isNotificationsDenied: $isNotificationsDenied,
                //    viewModel: quotesViewModel
                //)
                
            }
            .scrollIndicators(.hidden)
            .navigationTitle("🏠 Home")
            .toolbar {
                NavigationLink(destination: SettingsScreen(viewModel: quotesViewModel)) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.primary)
                }
            }
            .alert("Notifications Disabled", isPresented: $isNotificationsDenied) {
                Button("Cancel", role: .cancel) { }
                Button("Open Settings") {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }
            } message: {
                Text("Please enable notifications in Settings to use this feature.")
            }
        }
    }
    
    
}

