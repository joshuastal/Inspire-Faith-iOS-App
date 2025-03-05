//
//  CalendarDataListView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/4/25.
//
import SwiftUI
import Foundation
import ElegantCalendar

struct CalendarDataListView: View {
    let date: Date
        let height: CGFloat
        
        private var countForDate: Int {
            let day = Calendar.current.component(.day, from: date)
            let month = Calendar.current.component(.month, from: date)
            return (day + month) % 10 + 1
        }
        
        var body: some View {
            let count = countForDate
            
            return ScrollView {
                VStack(spacing: 0) {
                    // Debug info
                    Text("Generated \(count) items for \(date, style: .date)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    // Force centering by using GeometryReader
                    ForEach(0..<count, id: \.self) { index in
                        CalendarDataView(date: date, index: index + 1)
                    }
                    .padding(.trailing, 35) // Apply horizontal padding here to all cells
                }
                .frame(width: UIScreen.main.bounds.width - 32) // Force width of the main VStack
                .frame(maxWidth: .infinity) // Center it
            }
        }
}
