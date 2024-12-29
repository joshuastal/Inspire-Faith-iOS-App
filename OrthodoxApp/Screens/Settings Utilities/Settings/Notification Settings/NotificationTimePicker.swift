//
//  NotificationTimePicker.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import SwiftUI

struct NotificationTimePicker: View {
    @ObservedObject var notificationSettings: NotificationSettings
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            DatePicker("Notification Time",
                       selection: notificationSettings.notificationTimeBinding,
                       displayedComponents: .hourAndMinute)
            .datePickerStyle(.wheel)
            .labelsHidden()
            .navigationTitle("Set Notification Time")
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
}
