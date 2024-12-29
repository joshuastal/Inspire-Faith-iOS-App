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
    @ObservedObject var viewModel: QuotesViewModel
    @State private var isNotificationsDenied = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
            }
            .onAppear {
                if viewModel.allQuotes.isEmpty {
                    viewModel.fetchQuotes(db: Firestore.firestore())
                }
                
                
                checkNotificationStatusAndSchedule(
                    isNotificationsDenied: $isNotificationsDenied,
                    viewModel: viewModel
                )
            }
            .navigationTitle("🏠 Home Screen")
            .toolbar {
                NavigationLink(destination: SettingsScreen(viewModel: viewModel)) {
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

#Preview { HomeScreen(
    viewModel: {
        let viewModel = QuotesViewModel()
        // Add sample quotes
        viewModel.allQuotes = viewModel.testQuotes
        
        // Add some favorite quotes
        viewModel.favoriteQuotes = [viewModel.allQuotes[0]] // Make the first quote a favorite
        
        return viewModel
    }())
}
