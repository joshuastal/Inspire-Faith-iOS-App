import UIKit
import BackgroundTasks
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    var quotesViewModel: QuotesViewModel!

    // Called when the app finishes launching
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        // Initialize the quotesViewModel from the shared instance
        quotesViewModel = QuotesViewModel.shared
            
        return true
    }
}

