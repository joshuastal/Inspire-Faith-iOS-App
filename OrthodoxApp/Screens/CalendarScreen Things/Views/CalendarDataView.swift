import ElegantCalendar
//
//  CalendarDataView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/4/25.
//
import SwiftUI

struct CalendarDataView: View {
    let calendarDay: CalendarDay

    var body: some View {
        HStack {
            // Colored tag
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.orange)
                .frame(width: 5, height: 30)

            VStack(alignment: .leading) {
                Text("\(calendarDay.fastLevelDesc)")
                    .font(.system(size: 16))
            }
            
            Spacer()
        }
        .padding(8)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
        //.padding(.horizontal)
        .padding(.vertical, 4)
    }
}
