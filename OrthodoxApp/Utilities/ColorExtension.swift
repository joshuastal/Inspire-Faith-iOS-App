//
//  ColorExtension.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//

import Foundation
import SwiftUI

// Create an extension to store and retrieve colors using UserDefaults
extension Color: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else { return nil }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            self = Color(uiColor: color ?? .blue) // Default to blue if decode fails
        } catch {
            return nil
        }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false)
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}
