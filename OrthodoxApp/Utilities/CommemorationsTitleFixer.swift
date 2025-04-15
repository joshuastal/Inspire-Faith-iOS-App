//
//  CommemorationsTitleFixer.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/5/25.
//

import Foundation

struct CommemorationsTitleFixer {
    // Static array of replacement strings
    private static let replacements: [(String, String)] = [
        ("First (4th c.) and Second (9th c.) Findings of the Precious Head of St John the Baptist","1st & 2nd Findings of St John the Baptist's head"),
        ("Our ", ""),
        ("Venerable ", ""),
        ("Righteous ", ""),
        ("The ", ""),
        ("Pious ", ""),
        ("Holy ", ""),
        ("Fathers", "Frs."),
        ("Father", "Fr."),
        ("St", "St."),
        ("Saint", "St."),
        ("Mother", "Mthr."),
        ("Thirty-four", "34"),
        ("The Twenty Thousand Martyrs burned to death in their church in Nicomedia (ca. 304).",
         "20,000 Burned Nicomedia Martyrs")
    ]
    
    /// Formats a story title by applying various transformations and abbreviations
    /// - Parameter title: The original title string to format
    /// - Returns: A formatted, potentially shortened version of the title
    static func formatTitle(_ title: String) -> String {
        // Apply transformations
        let processedTitle = replaceStrings(in: title)
        return truncateAtComma(processedTitle)
    }
    
    // Helper function to apply string replacements
    private static func replaceStrings(in text: String) -> String {
        replacements.reduce(text) { result, pair in
            result.replacingOccurrences(of: pair.0, with: pair.1)
        }
    }
    
    // Helper function to truncate title at first comma
    private static func truncateAtComma(_ text: String) -> String {
        // Special case for the 20,000 martyrs title
        if text.contains("20,000") {
            return text
        }
        if let range = text.range(of: ",") {
            return String(text[..<range.lowerBound])
        }
        return text
    }
}
