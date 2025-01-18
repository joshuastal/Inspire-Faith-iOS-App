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
    //@State private var isNotificationsDenied = false
    
    var fastLevel: String? {
        orthocalViewModel.calendarDay?.fastExceptionDesc
    }
    
    
    var FastExceptions = [
        "",
        "Wine and Oil are Allowed",
        "Fish, Wine and Oil are Allowed",
        "Wine and Oil are Allowed",
        "Fish, Wine and Oil are Allowed",
        "Wine is Allowed",
        "Wine, Oil and Caviar are Allowed",
        "Meat Fast",
        "Strict Fast (Wine and Oil)",
        "Strict Fast",
        "No overrides",
        "Fast Free",
    ]
    
    
    // Add a computed property for the title logic
    var fastTitle: String {
        guard let level = fastLevel else { return "" }
        
        // Multiple conditions with a switch
        switch level {
        case "", "Fast Free":
            return "🍽️"
        case
            "Wine and Oil are Allowed", "Wine is Allowed", "Strict Fast (Wine and Oil)":
            return "🍷 🫒"
        case
            "Fish, Wine and Oil are Allowed", "Wine, Oil and Caviar are Allowed":
            return "🐟 🍷 🫒"
        case "Meat Fast":
            return "🧀 🐟 🍷 🫒"
        case
            "Fast", "No overrides":
            return "🥬 🥕 🍎"
        case
            "Strict Fast":
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
                    
                    // Feast Block
                    if let feasts = orthocalViewModel.calendarDay?.feasts, !feasts.isEmpty {
                        HomePill(
                            iconName: "party.popper",
                            content: "Feasts: \(feasts.joined(separator: ", \n"))",
                            //iconOffset: CGPoint(x: -10, y: 0),
                            //textOffset: CGPoint(x: -11, y: 0),
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
//            .alert("Notifications Disabled", isPresented: $isNotificationsDenied) {
//                Button("Cancel", role: .cancel) { }
//                Button("Open Settings") {
//                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
//                        UIApplication.shared.open(settingsURL)
//                    }
//                }
//            } message: {
//                Text("Please enable notifications in Settings to use this feature.")
//            }
        }
    }
    
    
}

