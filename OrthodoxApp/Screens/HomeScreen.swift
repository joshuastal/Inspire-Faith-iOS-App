import SwiftUI
import UserNotifications
import FirebaseCore
import FirebaseFirestore

struct HomeScreen: View {
    let db = Firestore.firestore()
    @ObservedObject var quotesViewModel: QuotesViewModel
    @ObservedObject var orthocalViewModel: OrthocalViewModel  // Add this for calendar data
    @State private var isNotificationsDenied = false
    
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 16) {
                    
                    HStack (spacing: 8) {
                        
                        // Fasting Block
                        if orthocalViewModel.calendarDay != nil {
                            let fastDetector = FastLevelDetector(orthocalViewModel: orthocalViewModel, specificCalendarDay: orthocalViewModel.calendarDay)
                            DefaultContentPill(
                                iconName: "fork.knife",
                                content: "Fast: \(fastDetector.fastTitle)"
                            )
                            .padding(.leading, 8)
                        }
                        
                        // Tone Block
                        if let tone = orthocalViewModel.calendarDay?.tone {
                            DefaultContentPill (
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
                        DefaultContentPill(
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
                checkNotificationStatusAndSchedule(
                    isNotificationsDenied: $isNotificationsDenied,
                    viewModel: quotesViewModel
                )
                
                //print("\(String(describing: quotesViewModel.loadDailyQuote()))")
                
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

