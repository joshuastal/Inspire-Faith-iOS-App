//
//  DailyVerseView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/3/25.
//

import SwiftUI

struct DailyVerseView: View {
    @StateObject private var verseProvider = VerseProvider()
    @AppStorage("verseFontSize") private var verseFontSize: Double = 18
    
    // Format today's date
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        if let verse = verseProvider.currentVerse {
            VStack(alignment: .leading, spacing: 16) {
                // Header Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Daily Verse")
                        .font(.custom("AvenirLTStd-Heavy", size: 24))
                        .foregroundColor(.primary)
                        .padding(.top, 12)
                    
                    Text(formattedDate)
                        .font(.custom("AvenirLTStd-Medium", size: 14))
                        .foregroundColor(.secondary)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color(.systemGray4))
                }
                .padding(.bottom, 8)
                
                // Quote Section
                VStack(alignment: .leading, spacing: 16) {
                    // Icon and quote
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "quote.opening")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        Text(verse.text)
                            .font(.custom("AvenirLTStd-Medium", size: verseFontSize))
                            .lineSpacing(8)
                            .multilineTextAlignment(.leading)
                    }
                    
                    // Author with styling
                    HStack {
                        Spacer()
                        Text("— \(verse.reference)")
                            .font(.custom("AvenirLTStd-Heavy", size: verseFontSize))
                            .foregroundColor(.secondary)
                    }
                }
                
                // Buttons Section
                VerseCardButtonsView(verse: verse)
                    .padding(.bottom, 8)
                    .padding(.leading, 8)
            }
            // Padding for card content with relation to the outline
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            .frame(maxWidth: .infinity)
            // Begin Card Outline
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))  // or any color you want
                    .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
                    .shadow(radius: 2)
            )
            // End Card Outline
            .padding(.horizontal, 8)
        }
    }
}

struct VerseCardButtonsView: View {
    let verse: BibleVerse
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                shareVerse()
            }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
            }
            
            // Add more buttons as needed
            
            Spacer()
        }
        .padding(.top, 8)
    }
    
    private func shareVerse() {
        let textToShare = "\"\(verse.text)\"\n— \(verse.reference)"
        let activityVC = UIActivityViewController(
            activityItems: [textToShare],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}



struct DailyVerseView_Previews: PreviewProvider {
    static var previews: some View {
        DailyVerseView()
    }
}
