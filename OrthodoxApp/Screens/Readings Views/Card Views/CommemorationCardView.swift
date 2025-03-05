//
//  CommemorationCardView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import SwiftUI

struct CommemorationCardView: View {
    let story: Story
    @AppStorage("readingFontSize") private var readingFontSize: Double = 19 // Add this line

    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            let formattedTitle = CommemorationsTitleFixer.formatTitle(story.title)

            // Story header
            Text(formattedTitle)
                .font(.custom("AvenirLTStd-Black", size: readingFontSize + 0.5))
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            // Story paragraphs
            VStack(alignment: .leading, spacing: 20) { // Larger spacing for visual clarity
                ForEach(formatStory(story.story), id: \.self) { paragraph in
                    Text("\(paragraph) \n")
                        .font(.custom("AvenirLTStd-Medium", size: readingFontSize))
                        .lineSpacing(10)
                }
            }
            .padding(.vertical, 4)
        }
        .padding(16)
        .background(Color(.systemGray5))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // Helper function to split and clean story paragraphs
    private func formatStory(_ rawStory: String) -> [String] {
        print("Raw story input: \(rawStory)") // Debugging: log the input

        let cleanedStory = rawStory
            .replacingOccurrences(of: "</p>", with: "\n")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "<i>", with: "")
            .replacingOccurrences(of: "</i>", with: "")
        
        print("Cleaned story: \(cleanedStory)") // Debugging: log the cleaned story

        // Split into paragraphs and clean up whitespace
        let paragraphs = cleanedStory
            .components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        print("Formatted paragraphs: \(paragraphs)") // Debugging: log the paragraphs
        return paragraphs
    }
}




#Preview {
    CommemorationCardView(story: Story(
        title: "Preview Story",
        story: "This is a test story about a test. <p>The test was very long and involved many words.</p> <p>The test was very long and involved many words.</p> <p>The test was very long and involved many words.</p> <p>The test was very long and involved many words.</p> <p>The test was very long and involved many words.</p>"
    ))
}
