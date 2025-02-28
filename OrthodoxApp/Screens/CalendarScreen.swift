import SwiftUI

struct InfiniteCalendarScreen: View {
    @StateObject private var viewModel = CalendarViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Month year display with controls
                HStack {
                    Button(action: {
                        viewModel.moveToPreviousMonth()
                        // Explicitly tell SwiftUI that tab view selection should update too
                        viewModel.synchronizeTabView = true
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(width: 44, height: 44)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text(viewModel.currentMonth.formatted(format: "MMMM yyyy"))
                        .font(.title.bold())
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.moveToNextMonth()
                        // Explicitly tell SwiftUI that tab view selection should update too
                        viewModel.synchronizeTabView = true
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(width: 44, height: 44)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(.systemBackground))
                
                Divider()
                
                // Days of the week header
                WeekdayHeaderView()
                    .background(Color(.systemBackground))
                
                Divider()
                
                // Infinite scrolling calendar
                TabView(selection: $viewModel.currentMonth) {
                    ForEach(-24...24, id: \.self) { monthOffset in
                        if let currentDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())),
                           let monthDate = Calendar.current.date(byAdding: .month, value: monthOffset, to: currentDate) {
                            MonthView(
                                month: monthDate,
                                selectedDate: $viewModel.selectedDate,
                                showingDateDetails: $viewModel.showingDateDetails
                            )
                            .tag(monthDate)
                            .id("month_view_\(monthDate.formatted(format: "yyyy-MM"))")
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxHeight: .infinity) // Take up all available space
                .onChange(of: viewModel.currentMonth) { newMonth in
                    // This prevents a potential infinite update loop while still ensuring
                    // updates happen when we need them
                    if viewModel.synchronizeTabView {
                        viewModel.synchronizeTabView = false
                    }
                }
                .onAppear {
                    // Ensure we're starting at the correct current month
                    viewModel.resetToCurrentMonth()
                }
            }
            .navigationTitle("🗓️ Calendar")
        }
        .overlayPopup(isPresented: $viewModel.showingDateDetails) {
            if let selectedDate = viewModel.selectedDate {
                CustomDateDetailView(date: selectedDate, isPresented: $viewModel.showingDateDetails)
            } else {
                // Fallback if no date is selected (shouldn't happen)
                Text("No date selected")
                    .padding()
            }
        }
    }
}

struct WeekdayHeaderView: View {
    private let days = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}

struct MonthView: View {
    let month: Date
    @Binding var selectedDate: Date?
    @Binding var showingDateDetails: Bool
    
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

struct DayCell: View {
    let date: Date
    let month: Date
    @Binding var selectedDate: Date?
    @Binding var showingDateDetails: Bool
    
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
                                .fill(Color.blue)
                                .frame(width: 46, height: 46) // Larger circle
                        } else if isToday {
                            Circle()
                                .stroke(Color.blue, lineWidth: 2) // Slightly thicker border
                                .frame(width: 46, height: 46) // Larger circle
                        }
                    }
                )
                .foregroundColor(
                    isSelected ? .white :
                        isToday ? .blue :
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

// MARK: - Calendar Screen Previews
struct InfiniteCalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteCalendarScreen()
    }
}
