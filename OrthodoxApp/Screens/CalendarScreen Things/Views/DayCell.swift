//
//  DayCell.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/3/25.
//
import SwiftUI
import Foundation

struct DayCell: View {
    let date: Date
    let month: Date
    @Binding var selectedDate: Date?
    @Binding var showingDateDetails: Bool
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    private let calendar = Calendar.current
    
    var body: some View {
        Button(action: {
            // Create a clean date without time components to avoid time-related issues
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            selectedDate = calendar.date(from: components)
            showingDateDetails = true
        }) {
            Text("\(calendar.component(.day, from: date))")
                .font(.system(size: 20)) // Larger font size
                .fontWeight(isToday ? .bold : .regular)
                .frame(maxWidth: .infinity)
                .frame(height: 60) // Taller cell
                .background(
                    ZStack {
                        if isSelected {
                            Circle()
                                .fill(accentColor)
                                .frame(width: 46, height: 46) // Larger circle
                        } else if isToday {
                            Circle()
                                .stroke(accentColor, lineWidth: 2) // Slightly thicker border
                                .frame(width: 46, height: 46) // Larger circle
                        }
                    }
                )
                .foregroundColor(
                    isSelected ? .white :
                        isToday ? accentColor :
                        isCurrentMonth ? .primary : .secondary.opacity(0.5)
                )
        }
        .id("day-\(date.formatted(format: "yyyy-MM-dd"))") // Force refresh when date changes
    }
    
    private var isSelected: Bool {
        if let selectedDate = selectedDate {
            return calendar.isDate(date, inSameDayAs: selectedDate)
        }
        return false
    }
    
    private var isCurrentMonth: Bool {
        calendar.component(.month, from: date) == calendar.component(.month, from: month) &&
        calendar.component(.year, from: date) == calendar.component(.year, from: month)
    }
    
    private var isToday: Bool {
        calendar.isDateInToday(date)
    }
}
