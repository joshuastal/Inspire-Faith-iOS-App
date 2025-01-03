import Foundation

class OrthocalViewModel: ObservableObject {
    @Published var calendarDay: CalendarDay?
    @Published var errorMessage: String?

    // Load calendar day data from the API
    func loadCalendarDay() {
        print("\n🔄 Starting new data load at: \(Date())")
        
        APIClient.shared.fetchCalendarDay { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Print raw JSON
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("\n📥 Raw JSON received:")
                        print(jsonString)
                    }
                    
                    // Attempt to decode
                    do {
                        let calendarDay = try JSONDecoder().decode(CalendarDay.self, from: data)
                        print("\n✅ Successfully decoded CalendarDay:")
                        print("Date: \(calendarDay.year)-\(calendarDay.month)-\(calendarDay.day)")
                        print("Readings count: \(calendarDay.readings.count)")
                        print("Stories count: \(calendarDay.stories.count)")
                        if let feasts = calendarDay.feasts {
                            print("Feasts: \(feasts)")
                        } else {
                            print("No feasts for today")
                        }
                        
                        self.calendarDay = calendarDay
                        self.errorMessage = nil
                    } catch {
                        print("\n❌ Decoding error: \(error)")
                        self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                    }
                case .failure(let error):
                    print("\n❌ Network error: \(error)")
                    self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    self.calendarDay = nil
                }
            }
        }
    }
}
