//
//  AboutView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/26/24.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) private var openURL
    
    var attributedText: some View {
        (Text("While the quotes and daily verses in Inspire Faith are from a privately created and managed database, the other data is from the publicly available website: ")
        + Text("orthocal.info")
            .foregroundColor(.blue))
            .onTapGesture {
                if let url = URL(string: "https://orthocal.info") {
                    openURL(url)
                }
            }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Inspire Faith is an iOS Application that displays various quotes that pertain to the Christian faith. The quotes are mostly from Orthodox Christian saints or other Orthodox Christians, this application howevever, is not exclusive for Orthodox Christians nor does it contain Orthodox Christian quotes exclusively.")
                        
                        Text("The application retrieves the quotes from a Firestore database. It also allows users to favorite and unfavorite specific quotes, display only favorite quotes, see today's fasting rule, today's tone, and even if there are any celebratory feasts today! The daily readings are also available in the Readings section of the app.")
                        
                        Text("The Gregorian Calendar is used to determine the fasting rules and tone of the day. It also determines if there are any celebratory feasts today. With regards to fasting, the Home Screen shows what Orthodox Christians are allowed to eat that day!")
                        
                        attributedText
                        
                        Text("Fasting Legend:\n🧀🐟🍷🫒 - Dairy, Fish, Wine, and Oil allowed\n🐟🍷🫒 - Only Fish, Wine, and Oil allowed.\n🥬🥕🍎 - Essentially Vegan food allowed.\n🍷🫒 - Only Wine and Oil allowed.\n🍽️ - No Fast.\n🚫 - Essentially only Vegan food allowed.")
                        
                        
                    }
                    
                    Text("Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "No version number...")")
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("About Inspire Faith")
                        .font(.title)
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .imageScale(.large)
                            .frame(width: 44, height: 44)
                    }
                }
            }
        }
    }
}

#Preview { AboutView() }
