// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct CalendarDay: Codable {
    let paschaDistance, julianDayNumber, year, month: Int
    let day, weekday, tone: Int
    let titles: [String]
    let summaryTitle: String
    let feastLevel: Int
    let feastLevelDescription: String
    let feasts: [String]?
    let fastLevel: Int
    let fastLevelDesc: String
    let fastException: Int
    let fastExceptionDesc: String
    let saints: [String]?
    let serviceNotes: JSONNull?
    let abbreviatedReadingIndices: [Int]
    let readings: [Reading]
    let stories: [Story]

    enum CodingKeys: String, CodingKey {
        case paschaDistance = "pascha_distance"
        case julianDayNumber = "julian_day_number"
        case year, month, day, weekday, tone, titles
        case summaryTitle = "summary_title"
        case feastLevel = "feast_level"
        case feastLevelDescription = "feast_level_description"
        case feasts
        case fastLevel = "fast_level"
        case fastLevelDesc = "fast_level_desc"
        case fastException = "fast_exception"
        case fastExceptionDesc = "fast_exception_desc"
        case saints
        case serviceNotes = "service_notes"
        case abbreviatedReadingIndices = "abbreviated_reading_indices"
        case readings, stories
    }
}

// MARK: - Reading
struct Reading: Codable {
    let source, book, description, display: String
    let shortDisplay: String
    let passage: [Passage]

    enum CodingKeys: String, CodingKey {
        case source, book, description, display
        case shortDisplay = "short_display"
        case passage
    }
}

// MARK: - Passage
struct Passage: Codable {
    let book: String
    let chapter, verse: Int
    let content: String
    let paragraphStart: Bool

    enum CodingKeys: String, CodingKey {
        case book, chapter, verse, content
        case paragraphStart = "paragraph_start"
    }
}

enum Book: String, Codable {
    case act = "ACT"
    case mat = "MAT"
    case mrk = "MRK"
    case the2TI = "2TI"
}

// MARK: - Story
struct Story: Codable {
    let title, story: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
