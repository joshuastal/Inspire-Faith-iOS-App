import SwiftUI
import ElegantCalendar

struct CalendarScreen: View {
    @StateObject var calendarManager: ElegantCalendarManager
    @AppStorage("accentColor") private var accentColor: Color = .blue
    @ObservedObject var orthocalViewModel: OrthocalViewModel
    
    var theme: CalendarTheme {
        CalendarTheme(primary: accentColor)
    }
    
    init(orthocalViewModel: OrthocalViewModel) {
        self._orthocalViewModel = ObservedObject(wrappedValue: orthocalViewModel)
        
        // Keep the 12-month range for good performance
        let startDate = Calendar.current.date(byAdding: .month, value: -12, to: Date()) ?? Date()
        let endDate = Calendar.current.date(byAdding: .month, value: 12, to: Date()) ?? Date()
        
        // Create the configuration
        let configuration = CalendarConfiguration(
            startDate: startDate,
            endDate: endDate
        )
        
        // Initialize the calendar manager with configuration AND initialMonth
        _calendarManager = StateObject(wrappedValue: {
            let manager = ElegantCalendarManager(
                configuration: configuration,
                initialMonth: Date() // This sets the calendar to start at today's month
            )
            return manager
        }())
    }

    var body: some View {
        ElegantCalendarView(calendarManager: calendarManager)
            .theme(theme)
//            .vertical() // uncomment for horizontal scrolling
            .onAppear {
                // Set both delegate and datasource
                calendarManager.delegate = self
                calendarManager.datasource = self
            }
    }
}

// MARK: - Calendar Delegate implementation
extension CalendarScreen: ElegantCalendarDelegate {
    func calendar(didSelectDay date: Date) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        if let year = components.year, let month = components.month, let day = components.day {
            print("Selected date: \(year)/\(month)/\(day)")
            Task {
                await orthocalViewModel.loadChosenCalendarDay(year: year, month: month, day: day)
            }
        }
    }
    
    func calendar(willDisplayMonth date: Date) {
        // Required by protocol but we don't need to implement anything
    }
}

// MARK: - Calendar DataSource implementation
extension CalendarScreen: ElegantCalendarDataSource {
    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        print("Creating view for selected date: \(date) with size: \(size)")
        return AnyView(
            CalendarDataListView(date: date, height: size.height)
        )
    }
    
    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
            // Calculate the same number of items that the view would show
            let day = Calendar.current.component(.day, from: date)
            let month = Calendar.current.component(.month, from: date)
            let numberOfItems = (day + month) % 10 + 1
            
            // Make the opacity directly proportional to the number of items
            // Scale between 0.1 (minimum) and 0.8 (maximum)
            let opacity = 0.1 + (Double(numberOfItems) / 10.0) * 0.7
            
            return opacity
        }
        
    
    func calendar(canSelectDate date: Date) -> Bool {
        return true
    }
}
