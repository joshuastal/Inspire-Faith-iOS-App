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

    
    private var formattedStoryTitle: String {
            let storyTitle = story.title
                .replacingOccurrences(of: "Our ", with: "")
                .replacingOccurrences(of: "Venerable ", with: "")
                .replacingOccurrences(of: "Righteous ", with: "")
                .replacingOccurrences(of: "The ", with: "")
                .replacingOccurrences(of: "Holy ", with: "")
                .replacingOccurrences(of: "Fathers", with: "Frs.")
                .replacingOccurrences(of: "Father", with: "Fr.")
                .replacingOccurrences(of: "St", with: "St.")
                .replacingOccurrences(of: "Saint", with: "St.")
                .replacingOccurrences(of: "Mother", with: "Mthr.")
                .replacingOccurrences(
                    of: "The Twenty Thousand Martyrs burned to death in their church in Nicomedia (ca. 304).",
                    with: "20,000 Burned Nicomedia Martyrs"
                )

            // Find the range of "," and truncate if found
            if storyTitle.contains("20,000") {
                return storyTitle
            } else if let range = storyTitle.range(of: ",") {
                return String(storyTitle[..<range.lowerBound]) // Truncate at ","
            } else {
                return storyTitle
            }
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Story header
            Text(formattedStoryTitle)
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
