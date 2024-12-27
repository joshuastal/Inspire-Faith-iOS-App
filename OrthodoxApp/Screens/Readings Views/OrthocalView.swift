import SwiftUI

struct OrthocalView: View {
    @StateObject private var viewModel = OrthocalViewModel()

    var body: some View {
        VStack {
            if let calendarDay = viewModel.calendarDay {
                // Show calendar day details
                Text("Day: \(calendarDay.day)")
                Text("Month: \(calendarDay.month)")
                Text("Year: \(calendarDay.year)")
                Text("Summary Title: \(calendarDay.summaryTitle)")
                // Add other properties as needed
            } else if let error = viewModel.errorMessage {
                // Show error message
                Text(error)
                    .foregroundColor(.red)
            } else {
                // Show loading spinner
                ProgressView("Loading...")
            }
        }
        .onAppear {
            // Load calendar day data when the view appears
            viewModel.loadCalendarDay()
        }
    }
}
