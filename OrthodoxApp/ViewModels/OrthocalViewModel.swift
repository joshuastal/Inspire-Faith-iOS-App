import Foundation

class OrthocalViewModel: ObservableObject {
    @Published var calendarDay: CalendarDay?
    @Published var errorMessage: String?

    // Load calendar day data from the API
    func loadCalendarDay() {
        APIClient.shared.fetchCalendarDay { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Attempt to decode the raw data into CalendarDay struct
                    do {
                        let calendarDay = try JSONDecoder().decode(CalendarDay.self, from: data)
                        self.calendarDay = calendarDay // Save the decoded object
                        self.errorMessage = nil // Clear error if decoding is successful
                    } catch {
                        self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                    }
                case .failure(let error):
                    self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    self.calendarDay = nil
                }
            }
        }
    }
}
