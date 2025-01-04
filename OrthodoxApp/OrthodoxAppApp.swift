import SwiftUI
import FirebaseCore
import FirebaseFirestore

enum AppState {
    case loading    // Show Launch Screen or Placeholder
    case ready      // Main Content Ready
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct OrthodoxAppApp: App {
    @StateObject private var quotesViewModel = QuotesViewModel()
    @StateObject private var orthocalViewModel = OrthocalViewModel()
    @State private var appState: AppState = .loading

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @AppStorage("appTheme") private var selectedTheme: String = AppTheme.system.rawValue
    @AppStorage("accentColor") private var accentColor: Color = .blue

    var body: some Scene {
        WindowGroup {
            ZStack {
                if appState == .loading {
                    LaunchScreen()
                        .transition(.opacity) // Smooth fade-out
                } else {
                    ContentView(
                        quotesViewModel: quotesViewModel,
                        orthocalViewModel: orthocalViewModel
                    )
                    .preferredColorScheme(getColorScheme())
                    .tint(accentColor)
                    .transition(.opacity) // Smooth fade-in
                }
            }
            .animation(.easeInOut(duration: 0.5), value: appState) // Crossfade effect
            .task {
                await loadApp()
            }
        }
    }




    private func loadApp() async {
        do {
            // Fetch and prepare data
            try await quotesViewModel.fetchQuotes(db: Firestore.firestore())
            await orthocalViewModel.loadCalendarDay()

            // Allow UI to initialize
            //try await Task.sleep(nanoseconds: 10_000_000_000) // 1 second (optional for smoother transition)

            // Set state to ready
            await MainActor.run {
                withAnimation(.easeInOut) {
                    appState = .ready
                }
            }
        } catch {
            print("Error loading app: \(error)")
            await MainActor.run {
                appState = .ready // Fallback to main content
            }
        }
    }

    private func getColorScheme() -> ColorScheme? {
        switch selectedTheme {
        case AppTheme.light.rawValue: return .light
        case AppTheme.dark.rawValue: return .dark
        default: return nil
        }
    }
}



enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}
