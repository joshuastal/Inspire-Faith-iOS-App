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
            return "🚫"
        case "Fast — Wine and Oil are Allowed":
            return "🥩 🧀 🐟"
        case "Fast — Fish, Wine and Oil are Allowed":
            return "🥩 🧀"
        case "Fast":
            return "💀"
        default:
            return "Fast \(level)"
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 16) {
                    
                    HStack (spacing: 8) {
                        if orthocalViewModel.calendarDay != nil {
                            HomePill(
                                iconName: "fork.knife",
                                content: "Fast: \(fastTitle)",
                                iconOffset: CGPoint(x: -15, y: 0),
                                textOffset: CGPoint(x: -15, y: 0),
                                scalesText: true
                            )
                            .padding(.leading, 8)
                        }
                        
                        if let tone = orthocalViewModel.calendarDay?.tone {
                            HomePill (
                                iconName: "music.note",
                                content: "Tone: \(tone)"
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
            .onAppear {
                
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

#Preview {
    HomeScreen(
        quotesViewModel: {
            let viewModel = QuotesViewModel()
            // Add sample quotes
            viewModel.allQuotes = viewModel.testQuotes
            // Add some favorite quotes
            viewModel.favoriteQuotes = [viewModel.allQuotes[0]]
            return viewModel
        }(),
        orthocalViewModel: {
            let viewModel = OrthocalViewModel()
            // Add sample calendar day with required properties
            viewModel.calendarDay = CalendarDay(
                paschaDistance: 10,
                julianDayNumber: 2460000,
                year: 2024,
                month: 12,
                day: 25,
                weekday: 3,
                tone: 4,
                titles: ["Nativity of Our Lord"],
                summaryTitle: "Nativity of Our Lord",
                feastLevel: 7,
                feastLevelDescription: "Great Feast of the Lord",
                feasts: ["The Nativity of Our Lord God and Savior Jesus Christ"],
                fastLevel: 0,
                fastLevelDesc: "No Fast",
                fastException: 0,
                fastExceptionDesc: "",
                saints: ["Saint Nicholas the Wonderworker"],
                serviceNotes: JSONNull(),
                abbreviatedReadingIndices: [1, 2, 3],
                readings: [
                    Reading(
                        source: "Gospel",
                        book: "Matthew",
                        description: "Nativity Gospel",
                        display: "Matthew 1:18-25",
                        shortDisplay: "Mt 1:18-25",
                        passage: [
                            Passage(
                                book: "MAT",
                                chapter: 1,
                                verse: 18,
                                content: "Now the birth of Jesus Christ was as follows...",
                                paragraphStart: true
                            )
                        ]
                    )
                ],
                stories: [
                    Story(
                        title: "The Nativity of Christ",
                        story: "The story of Christ's birth..."
                    )
                ]
            )
            return viewModel
        }()
    )
}
