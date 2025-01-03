import Foundation
import UserNotifications
import SwiftUI

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show notification in foreground with banner and sound
        completionHandler([.banner, .sound])
    }
}

// Create a shared instance that can be accessed throughout the app
let notificationDelegate = NotificationDelegate()
