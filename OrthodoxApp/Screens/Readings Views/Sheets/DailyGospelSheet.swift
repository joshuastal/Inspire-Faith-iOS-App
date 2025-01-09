//
//  DailyGospelSheet.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/2/25.
//

import SwiftUI

struct DailyGospelSheet: View {
    let readings: [Reading]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(readings.indices, id: \.self) { index in
                        let reading = readings[index]
                        let reference = reading.display
                            .replacingOccurrences(of: ".", with: ":")
                        
                        if(reading.source.contains("Gospel")) {
                            ReadingCardView(reading: reading, reference: reference)
                        }
                        
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    Text("Daily Gospel Devotions")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.trailing, 15)
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

struct DailyGospelSheet_Previews: PreviewProvider {
    static var previews: some View {
        DailyGospelSheet(readings: [
            Reading(
                source: "Epistle",
                book: "Romans",
                description: "Reading from Romans",
                display: "Romans 8:14-21",
                shortDisplay: "Romans 8:14-21",
                passage: [
                    Passage(
                        book: "Romans",
                        chapter: 8,
                        verse: 14,
                        content: "For as many as are led by the Spirit of God, these are sons of God.",
                        paragraphStart: true
                    ),
                    Passage(
                        book: "Romans",
                        chapter: 8,
                        verse: 15,
                        content: "For you did not receive the spirit of bondage again to fear, but you received the Spirit of adoption by whom we cry out, Abba, Father.",
                        paragraphStart: false
                    )
                ]
            ),
            Reading(
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
        ])
    }
}

