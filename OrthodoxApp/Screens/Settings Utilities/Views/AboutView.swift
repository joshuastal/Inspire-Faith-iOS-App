//
//  AboutView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/26/24.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("About Inspire Faith")
                        .font(.title)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Inspire Faith is an iOS Application that displays various quotes that pertain to the Christian faith. The quotes are mostly from Orthodox Christian saints or other Orthodox Christians, this application howevever, is not exclusive for Orthodox Christian use nor does it contain Orthodox Christian quotes exclusively.")
                        
                        Text("The application retrieves the quotes from a Firestore database. It also allows users to favorite and unfavorite specific quotes, display only favorite quotes, see today's fasting rule, today's tone, and even if there are any celebratory feasts today! The daily readings are also available in the Readings section of the app.")
                    }
                    
                    Text("Version 1.0.0")
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                        // (.label()) adjusts color based on dark/light mode
                            .imageScale(.large)
                            .frame(width: 44, height: 44)
                    }
                }
            }
        }
    }
}

#Preview { AboutView() }
