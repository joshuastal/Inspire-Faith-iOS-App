import Foundation

@MainActor
class OrthocalViewModel: ObservableObject {
    @Published var calendarDay: CalendarDay?
    @Published var chosenCalendarDay: CalendarDay?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false  // Add this line

    // Load calendar day data from the API
    func loadCalendarDay() async {
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
    
    // In OrthocalViewModel.swift
    func loadChosenCalendarDay(year: Int, month: Int, day: Int) async {
        isLoading = true
        print("\n🔄 Starting new data load for specific date: \(year)/\(month)/\(day)")
        
        APIClient.shared.fetchChosenCalendarDay(year: year, month: month, day: day) { [weak self] result in
            guard let self = self else { return }
            
            Task { @MainActor in
                self.isLoading = false
                
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
                        print("\n✅ Successfully decoded CalendarDay for chosen date:")
                        print("Date: \(calendarDay.year)-\(calendarDay.month)-\(calendarDay.day)")
                        
                        self.chosenCalendarDay = calendarDay
                        self.errorMessage = nil
                    } catch {
                        print("\n❌ Decoding error: \(error)")
                        self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                    }
                case .failure(let error):
                    print("\n❌ Network error: \(error)")
                    self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    self.chosenCalendarDay = nil
                }
            }
        }
    }
}
