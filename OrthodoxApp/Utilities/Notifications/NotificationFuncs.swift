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

@MainActor
func scheduleNotification(viewModel: QuotesViewModel) {
    @AppStorage("notificationHour") var hour: Int = 8
    @AppStorage("notificationMinute") var minute: Int = 0
    
    let content = UNMutableNotificationContent()
    
    // Calculate if the specified time is still to come today
    let calendar = Calendar.current
    let now = Date()
    
    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    
    guard let targetTime = calendar.nextDate(after: now,
                                           matching: components,
                                           matchingPolicy: .nextTime) else {
        print("Could not calculate next notification date")
        return
    }
    
    // Get the quote for the target date
    let dailyQuote = viewModel.getDailyQuote(for: targetTime)
    
    content.title = "Daily Quote"
    content.body = "\"\(dailyQuote.quote)\""
    content.subtitle = "— \(dailyQuote.author)"
    content.sound = UNNotificationSound.default
    
    // Create trigger components for the notification
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents,
        repeats: true
    )
    
    let request = UNNotificationRequest(
        identifier: "dailyReminder",
        content: content,
        trigger: trigger
    )
    
    // Remove existing notifications
    UNUserNotificationCenter.current().removePendingNotificationRequests(
        withIdentifiers: ["dailyReminder"]
    )
    
    // Schedule the new notification
    UNUserNotificationCenter.current().add(request)
    print("Notification scheduled for \(targetTime) with quote: \(dailyQuote.quote)")
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
