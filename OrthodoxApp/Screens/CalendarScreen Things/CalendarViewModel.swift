import Foundation
import SwiftUI

// Date Extensions for Calendar Functionality
extension Date {
    /// Get the start of the month for a date
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    /// Get the end of the month for a date
    func endOfMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        components.day = -1
        return calendar.date(byAdding: components, to: self.startOfMonth())!
    }
    
    /// Check if a date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// Get a formatted string for a specific format
    func formatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// Convenience wrapper for date selection state
class CalendarViewModel: ObservableObject {
    // Store the current month as a clean date (just year and month components)
    @Published var currentMonth: Date
    @Published var selectedDate: Date?
    @Published var showingDateDetails: Bool = false
    
    // Flag to control tab view synchronization
    @Published var synchronizeTabView: Bool = false
    
    init() {
        // Initialize with a clean date - current month
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        self.currentMonth = calendar.date(from: components) ?? Date()
    }
    
    // Reset to the current month
    func resetToCurrentMonth() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        if let currentDate = calendar.date(from: components) {
            // Only update if there's a real change needed
            if !calendar.isDate(currentMonth, equalTo: currentDate, toGranularity: .month) {
                currentMonth = currentDate
            }
        }
    }
    
    // Get all dates for the current month view (including overflow from prev/next months)
    func fetchDatesForMonth() -> [Date] {
        let calendar = Calendar.current
        
        // Start of the month
        let startOfMonth = currentMonth.startOfMonth()
        
        // Get the weekday of the first day (1 = Sunday, 2 = Monday, etc)
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        
        // Calculate offset to fill the grid from the beginning of the week
        let offsetDays = firstWeekday - 1
        
        // Array to store all dates
        var dates: [Date] = []
        
        // Previous month dates to fill the beginning of the grid
        if offsetDays > 0 {
            for day in stride(from: offsetDays, through: 1, by: -1) {
                if let date = calendar.date(byAdding: .day, value: -day, to: startOfMonth) {
                    dates.append(date)
                }
            }
        }
        
        // Current month dates
        let daysInMonth = calendar.range(of: .day, in: .month, for: startOfMonth)?.count ?? 0
        for day in 0..<daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day, to: startOfMonth) {
                dates.append(date)
            }
        }
        
        // Next month dates to fill the remaining cells (6 rows of 7 days)
        let totalDaysNeeded = 42 // 6 rows x 7 days
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
    
    // Move to previous month
    func moveToPreviousMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            // Extract just year and month to avoid time component issues
            let components = calendar.dateComponents([.year, .month], from: newDate)
            if let cleanDate = calendar.date(from: components) {
                currentMonth = cleanDate
            }
        }
    }
    
    // Move to next month
    func moveToNextMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            // Extract just year and month to avoid time component issues
            let components = calendar.dateComponents([.year, .month], from: newDate)
            if let cleanDate = calendar.date(from: components) {
                currentMonth = cleanDate
            }
        }
    }
    
    // Jump to a specific month
    func jumpToMonth(_ date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        if let cleanDate = calendar.date(from: components) {
            currentMonth = cleanDate
            synchronizeTabView = true
        }
    }
    
    // Select a date and show details
    func selectDate(_ date: Date) {
        // Create a clean date without time components
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        selectedDate = calendar.date(from: components)
        showingDateDetails = true
    }
}

// Custom modifier for calendar cells
struct CalendarCellModifier: ViewModifier {
    let isSelected: Bool
    let isCurrentMonth: Bool
    let isToday: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 36, height: 36)
                    } else if isToday {
                        Circle()
                            .stroke(Color.blue, lineWidth: 1)
                            .frame(width: 36, height: 36)
                    }
                }
            )
            .foregroundColor(
                isSelected ? .white :
                    isToday ? .blue :
                    isCurrentMonth ? .primary : .secondary
            )
    }
}

extension View {
    func calendarCell(isSelected: Bool, isCurrentMonth: Bool, isToday: Bool) -> some View {
        self.modifier(CalendarCellModifier(isSelected: isSelected, isCurrentMonth: isCurrentMonth, isToday: isToday))
    }
}
