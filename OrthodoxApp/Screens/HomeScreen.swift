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
    @StateObject var orthocalViewModel = OrthocalViewModel()  // Add this for calendar data
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
            return "No Fast Today! 😄"
        case "Fast — Wine and Oil are Allowed":
            return "Fast — Wine and Oil are Allowed 🥩 🧀 🐟"
        case "Fast — Fish, Wine and Oil are Allowed":
            return "Fast — Fish, Wine and Oil are Allowed 🥩 🧀"
        case "Fast":
            return "Strict Fast 🥩 🧀 🐟 🍷"
        default:
            return "Fast \(level)"
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if orthocalViewModel.calendarDay != nil {
                        HomePill(
                            iconName: "fork.knife",
                            content: "Fast: \(fastTitle)"
                        )
                    }
                                    
                    DailyQuoteCardView(quote: quotesViewModel.getDailyQuote(), viewModel: quotesViewModel)
                    
                    DailyVerseView()
                    
                    Spacer()
                }
            }
            .onAppear {
                if quotesViewModel.allQuotes.isEmpty {
                    quotesViewModel.fetchQuotes(db: Firestore.firestore())
                }
                
                orthocalViewModel.loadCalendarDay()  // Add this line to load calendar data
                
                checkNotificationStatusAndSchedule(
                    isNotificationsDenied: $isNotificationsDenied,
                    viewModel: quotesViewModel
                )
            }
            .navigationTitle("🏠 Home Screen")
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
            viewModel.favoriteQuotes = [viewModel.allQuotes[0]] // Make the first quote a favorite
            
            return viewModel
        }())
}
