//
//  MonthView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/3/25.
//
import SwiftUI
import Foundation

struct MonthView: View {
    let month: Date
    @Binding var selectedDate: Date?
    @Binding var showingDateDetails: Bool
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    // Cache dates to avoid recalculation
    private var dates: [Date] {
        extractDates()
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) { // Increased spacing
            ForEach(dates, id: \.self) { date in
                DayCell(
                    date: date,
                    month: month,
                    selectedDate: $selectedDate,
                    showingDateDetails: $showingDateDetails
                )
            }
        }
        .padding(.horizontal, 10) // Increased padding
        .padding(.vertical, 5)
        .id("month-\(month.formatted(format: "yyyy-MM"))") // Force refresh when month changes
    }
    
    private func extractDates() -> [Date] {
        // Get start of the month
        let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        
        // Get the first weekday (1 = Sunday, 2 = Monday, etc)
        let firstWeekday = calendar.component(.weekday, from: monthStart)
        
        // Calculate how many days we need to show from the previous month
        let daysFromPreviousMonth = (firstWeekday - 1) % 7
        
        var dates: [Date] = []
        
        // Previous month dates
        if daysFromPreviousMonth > 0 {
            for day in (1...daysFromPreviousMonth).reversed() {
                if let date = calendar.date(byAdding: .day, value: -day, to: monthStart) {
                    dates.append(date)
                }
            }
        }
        
        // Current month dates - get the range of days in the month
        let daysInMonth = calendar.range(of: .day, in: .month, for: monthStart)?.count ?? 0
        
        for day in 0..<daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day, to: monthStart) {
                dates.append(date)
            }
        }
        
        // Next month dates - fill to complete 6 rows
        let totalDaysNeeded = 42 // 6 rows × 7 days
        let remainingDays = totalDaysNeeded - dates.count
        
        if remainingDays > 0 && !dates.isEmpty {
            let lastDate = dates.last!
            for day in 1...remainingDays {
                if let date = calendar.date(byAdding: .day, value: day, to: lastDate) {
                    dates.append(date)
                }
            }
        }
        
        return dates
    }
}
