//
//  NotificationFuncs.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import Foundation
import SwiftUI
import UserNotifications

func checkNotificationStatus() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        DispatchQueue.main.async {
            if settings.authorizationStatus == .notDetermined {
                // First time - request permission
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Permission granted")
                    } else {
                        print("Permission denied")
                    }
                }
            }
        }
    }
}

func checkNotificationStatusAndSchedule(isNotificationsDenied: Binding<Bool>, viewModel: QuotesViewModel) {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        DispatchQueue.main.async {
            switch settings.authorizationStatus {
            case .authorized:
                scheduleNotification(viewModel: viewModel)
            case .denied:
                // Use binding's wrappedValue to modify the state
                isNotificationsDenied.wrappedValue = true
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    DispatchQueue.main.async {
                        if success {
                            scheduleNotification(viewModel: viewModel)
                        }
                    }
                }
            default:
                break
            }
        }
    }
}

func scheduleNotification(viewModel: QuotesViewModel) {
    let content = UNMutableNotificationContent()
    
    let dailyQuote = viewModel.getDailyQuote()
    
    content.title = "Daily Quote"
    content.body = "\"\(dailyQuote.quote)\""
    content.subtitle = "— \(dailyQuote.author)"
    content.sound = UNNotificationSound.default
    
    @AppStorage("notificationHour") var hour: Int = 8
    @AppStorage("notificationMinute") var minute: Int = 0
    
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    // Create the trigger (repeating daily at specified time)
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents,
        repeats: true
    )
    
    let request = UNNotificationRequest(
        identifier: "dailyReminder",  // Fixed identifier for updating/canceling
        content: content,
        trigger: trigger
    )
    
    // Remove any existing notification with same identifier
    UNUserNotificationCenter.current().removePendingNotificationRequests(
        withIdentifiers: ["dailyReminder"]
    )
    
    // Schedule the new notification
    UNUserNotificationCenter.current().add(request)
    print("Notification scheduled")
}

func rescheduleNotifications(viewModel: QuotesViewModel) {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        DispatchQueue.main.async {
            if settings.authorizationStatus == .authorized {
                scheduleNotification(viewModel: viewModel)
            }
        }
    }
}
