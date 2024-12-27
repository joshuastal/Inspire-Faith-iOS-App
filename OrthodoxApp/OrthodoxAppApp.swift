import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct OrthodoxAppApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Add theme support
    @AppStorage("appTheme") private var selectedTheme: String = AppTheme.system.rawValue
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(getColorScheme())
                .tint(accentColor)
        }
    }
    
    // Add the theme helper function
    func getColorScheme() -> ColorScheme? {
        switch selectedTheme {
        case AppTheme.light.rawValue:
            return .light
        case AppTheme.dark.rawValue:
            return .dark
        default:
            return nil  // This will follow the system setting
        }
    }
}

// Add the theme enum
enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}
