//
//  CalendarDataListView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/4/25.
//
import SwiftUI
import Foundation

struct CalendarDataListView: View {
    let calendarDay: CalendarDay
    let orthocalViewModel: OrthocalViewModel

    var body: some View {

        let fastDetector = FastLevelDetector(
            orthocalViewModel: orthocalViewModel,
            specificCalendarDay: calendarDay)

        return ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {

                // FASTING BLOCK
                CalendarDataView(
                    content: "Fast: \(fastDetector.fastTitle)",
                    tagColor: Color("Calendar Data Block Colors/fastBlockColor")
                )
                // END FASTING BLOCK
                
                
                // TONE BLOCK
                CalendarDataView(
                    content: "Tone: \(calendarDay.tone)",
                    tagColor: Color("Calendar Data Block Colors/toneBlockColor")
                )
                // TONE BLOCK


                // FEASTS BLOCK
                if let feasts = calendarDay.feasts, !feasts.isEmpty {
                    CalendarDataView(
                        content: "Feasts: \(feasts.joined(separator: "; \n"))",
                        tagColor: Color("Calendar Data Block Colors/feastBlockColor")
                    )
                }
                // END FEASTS BLOCK

                
                // READINGS BLOCK
                let readings = calendarDay.readings
                if !readings.isEmpty {
                    let formattedReferences = readings.map { reading in
                        return reading.display.replacingOccurrences(
                            of: ".", with: ":")
                    }

                    
                    CalendarDataView(
                        content:
                            "Readings: \(formattedReferences.joined(separator: "; "))",
                        tagColor: Color("Calendar Data Block Colors/readingsBlockColor")
                    )
                }
                // END READINGS BLOCK

                // SAINTS BLOCK
                // Properly handle the optional saints array
                if let saints = calendarDay.saints, !saints.isEmpty {
                    CalendarDataView(
                        content: "Saints: \(saints.joined(separator: "; "))",
                        tagColor: Color("Calendar Data Block Colors/saintsBlockColor")
                    )
                }
                // END SAINTS BLOCK
            }
            .frame(width: UIScreen.main.bounds.width - 32)  // Force width of the main VStack
            .frame(maxWidth: .infinity)  // Center it
        }
    }
}
