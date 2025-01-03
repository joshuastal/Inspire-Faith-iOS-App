//
//  VerseProvider.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/3/25.
//

import Foundation

class VerseProvider: ObservableObject {
    @Published private(set) var currentVerse: BibleVerse?
    
    private let verses = [
        BibleVerse(
            text: "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.",
            reference: "John 3:16"
        ),
        BibleVerse(
            text: "I can do all this through him who gives me strength.",
            reference: "Philippians 4:13"
        ),
        BibleVerse(
            text: "Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.",
            reference: "Joshua 1:9"
        ),
        BibleVerse(
            text: "Trust in the Lord with all your heart and lean not on your own understanding.",
            reference: "Proverbs 3:5"
        ),
        // Add more verses as needed
    ]
    
    init() {
        updateDailyVerse()
    }
    
    func updateDailyVerse() {
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let verseIndex = (dayOfYear - 1) % verses.count
        currentVerse = verses[verseIndex]
    }
}
