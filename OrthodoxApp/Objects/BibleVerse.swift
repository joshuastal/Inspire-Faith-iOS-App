//
//  BibleVerse.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/3/25.
//

import Foundation

struct BibleVerse: Identifiable, Codable {
    var id = UUID()
    let text: String
    let reference: String
}


