import ElegantCalendar
import Foundation
//
//  CalendarDataListView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/4/25.
//
import SwiftUI

struct CalendarDataListView: View {
    let calendarDay: CalendarDay

    var body: some View {

        return ScrollView {
            VStack(spacing: 0) {
                

                CalendarDataView(calendarDay: calendarDay)
                    .padding(.trailing, 35)  // Apply horizontal padding here to all cells
            }
            .frame(width: UIScreen.main.bounds.width - 32)  // Force width of the main VStack
            .frame(maxWidth: .infinity)  // Center it
        }
    }
}
