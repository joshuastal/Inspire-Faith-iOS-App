//
//  NotificationSection.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//
import Foundation
import SwiftUI

struct NotificationSection: View {
    @ObservedObject var notificationSettings: NotificationSettings
    @Binding var showingDatePicker: Bool
    
    var body: some View {
        
        Section (header: Text("Daily Notification")){
            Button(action: {
                showingDatePicker = true
            }) {
                HStack {
                    Text("Daily Notification")
                        .foregroundStyle(Color(.label))
                    Spacer()
                    Text(notificationSettings.formattedTime)
                        .foregroundColor(.secondary)
                }
            }
        }
        
    }
}
