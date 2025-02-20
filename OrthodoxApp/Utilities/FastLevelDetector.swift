//
//  FastLevelDetector.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 1/22/25.
//
import Foundation
import SwiftUI

struct FastLevelDetector {
    
    @ObservedObject var orthocalViewModel: OrthocalViewModel

    enum FastLevels: Int {
        case NoFast = 0
        case Fast = 1
        case LentenFast = 2
        case ApostlesFast = 3
        case DormitionFast = 4
        case NativityFast = 5
    }

    
    var fastLevel: String? {
            orthocalViewModel.calendarDay?.fastExceptionDesc
        }
        
        var fastTitle: String {
            guard let level = fastLevel else { return "" }
            
            switch level {
            case "":
                // When there's no exception, check the base fast level
                if let baseLevel = orthocalViewModel.calendarDay?.fastLevel {
                    switch baseLevel {
                    case FastLevels.NoFast.rawValue:
                        return "🍽️"
                    case FastLevels.Fast.rawValue,
                         FastLevels.LentenFast.rawValue,
                         FastLevels.ApostlesFast.rawValue,
                         FastLevels.DormitionFast.rawValue,
                         FastLevels.NativityFast.rawValue:
                        return "🥬 🥕 🍎"
                    default:
                        return "🥬 🥕 🍎"  // Default to standard fast
                    }
                }
                return "🍽️"
                
            case "Fast Free":
                return "🍽️"
                
            case "Wine and Oil are Allowed",
                 "Wine is Allowed",
                 "Strict Fast (Wine and Oil)":
                return "🍷 🫒"
                
            case "Fish, Wine and Oil are Allowed",
                 "Wine, Oil and Caviar are Allowed":
                return "🐟 🍷 🫒"
                
            case "Meat Fast":
                return "🧀 🐟 🍷 🫒"
                
            case "Fast", "No overrides":
                // For "No overrides", we should check the base fast level
                if let baseLevel = orthocalViewModel.calendarDay?.fastLevel {
                    switch baseLevel {
                    case FastLevels.NoFast.rawValue:
                        return "🍽️"
                    case FastLevels.Fast.rawValue,
                         FastLevels.LentenFast.rawValue,
                         FastLevels.ApostlesFast.rawValue,
                         FastLevels.DormitionFast.rawValue,
                         FastLevels.NativityFast.rawValue:
                        return "🥬 🥕 🍎"
                    default:
                        return "🥬 🥕 🍎"  // Default to standard fast
                    }
                }
                return "🥬 🥕 🍎"
                
            case "Strict Fast":
                return "🚫"
                
            default:
                return "Fast \(level)"
            }
        }

}
