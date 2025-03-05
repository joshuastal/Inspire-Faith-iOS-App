import SwiftUI

struct CalendarScreen: View {
    @ObservedObject var orthocalViewModel: OrthocalViewModel
    @AppStorage("accentColor") private var accentColor: Color = .blue
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack {
                // 1. Calendar section with Today button
                HStack {
                    Spacer()
                    Button(action: {
                        // Return to today
                        selectedDate = Date()
                        loadDataForDate(selectedDate)
                    }) {
                        Label("Today", systemImage: "calendar.badge.clock")
                            .foregroundColor(accentColor)
                    }
                }
                .padding(.horizontal)
                //.padding(.bottom)

                // 2. Calendar section - contained in its own VStack with padding
                                VStack {
                                    DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .onChange(of: selectedDate) { _, newDate in
                                            loadDataForDate(newDate)
                                        }
                                        .accentColor(accentColor)
                                }
                                .padding(.horizontal)
                                .frame(height: 320) // Slightly taller to ensure no clipping
                                .padding(.bottom, 10) // Add explicit bottom padding
                                
                                // Clear divider with padding on both sides
                                Divider()

                // 3. Data display section
                ScrollView(showsIndicators: false){
                    VStack() {
                        if orthocalViewModel.isLoading {
                            ProgressView("Loading data...")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else if let calendarDay = orthocalViewModel
                            .chosenCalendarDay
                        {
                            CalendarDataListView(
                                calendarDay: calendarDay,
                                orthocalViewModel: orthocalViewModel)
                        } else {
                            Text("Select a date to view information")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("📅 Calendar")
            .onAppear {
                // Load today's data when the view appears
                loadDataForDate(Date())
            }
        }
    }

    private func loadDataForDate(_ date: Date) {
        let components = Calendar.current.dateComponents(
            [.year, .month, .day], from: date)
        if let year = components.year, let month = components.month,
            let day = components.day
        {
            print("Loading data for: \(year)/\(month)/\(day)")
            Task {
                await orthocalViewModel.loadChosenCalendarDay(
                    year: year, month: month, day: day)
            }
        }
    }
}
