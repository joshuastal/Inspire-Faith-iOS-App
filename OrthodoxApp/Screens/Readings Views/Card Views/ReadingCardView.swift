//
//  ReadingCardView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import SwiftUI

struct ReadingCardView: View {
    let reading: Reading
    let reference: String
    @AppStorage("readingFontSize") private var readingFontSize: Double = 19 // Add this line
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Reading header
            Text(reference)
                .font(.custom("AvenirLTStd-Black", size: readingFontSize + 0.5))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            // Passages
            VStack(alignment: .leading, spacing: 8) {
                ForEach(reading.passage, id: \.content) { passage in
                    Text("\(passage.content)\n")
                        .font(.custom("AvenirLTStd-Medium", size: readingFontSize))
                        .lineSpacing(10)
                }
            }
            .padding(.vertical, 4)
            
            // Source
            Text(reading.source)
                .font(.custom("AvenirLTStd-Light", size: readingFontSize))
                .foregroundColor(.secondary)
        }
        .padding(16)
        .background(Color(.systemGray5))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    let reading = Reading(
        source: "Gospel",
        book: "Matthew",
        description: "Reading from the Holy Gospel",
        display: "Matthew 9:9-13",
        shortDisplay: "Matt 9:9-13",
        passage: [
            Passage(
                book: "Matthew",
                chapter: 9,
                verse: 9,
                content: "As Jesus passed on from there, He saw a man named Matthew sitting at the tax office. And He said to him, Follow Me. So he arose and followed Him.",
                paragraphStart: true
            ),
            Passage(
                book: "Matthew",
                chapter: 9,
                verse: 10,
                content: "Now it happened, as Jesus sat at the table in the house, that behold, many tax collectors and sinners came and sat down with Him and His disciples.",
                paragraphStart: false
            )
        ]
    )
    
    let reference = reading.display
    
    ReadingCardView(reading: reading, reference: reference)
}
