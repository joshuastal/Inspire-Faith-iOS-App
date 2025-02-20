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
    
    // Get the updated daily quote (it is already refreshed by the background task)
    let dailyQuote = viewModel.dailyQuote ?? viewModel.getDailyQuote()
    
    content.title = "Daily Quote Reminder"
    content.body = "Your daily quote is ready!"
    content.sound = UNNotificationSound.default
    
    // Create trigger components for the notification
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    // Trigger the notification every 24 hours
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents,
        repeats: true // This ensures the notification repeats every 24 hours
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
    print("Notification scheduled for \(dailyQuote.quote) at \(hour):\(minute)")
}

func rescheduleNotifications(viewModel: QuotesViewModel) {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        DispatchQueue.main.async {
            if settings.authorizationStatus == .authorized {
                // Schedule notification immediately after the background task completes or app launch
                scheduleNotification(viewModel: viewModel)
            } else {
                print("Notification permissions not granted")
            }
        }
    }
}
