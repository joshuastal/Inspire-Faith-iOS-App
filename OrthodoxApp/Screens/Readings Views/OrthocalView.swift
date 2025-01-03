import SwiftUI


extension OrthocalViewModel {
    var hasProphecyReadings: Bool {
        guard let calendarDay = calendarDay else { return false }
        return calendarDay.readings.contains { reading in
            reading.source.contains("Prophecy")
        }
    }
}

struct OrthocalView: View {
    @StateObject private var viewModel = OrthocalViewModel()
    @State private var showingEpistleReadings = false
    @State private var showingGospelReadings = false
    @State private var showingCommemorations = false
    @State private var showingProphecyReadings = false
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 16) {
                // Daily Readings
                DataButtonView(
                    iconName: "book.fill",
                    title: "Daily Epistle Readings"
                ) {
                    // First show the sheet with existing data
                    showingEpistleReadings = true
                }
                
                DataButtonView(
                    iconName: "book.fill",
                    title: "Daily Gospel Readings"
                ) {
                    // First show the sheet with existing data
                    showingGospelReadings = true
                }
                
                if viewModel.hasProphecyReadings {
                    DataButtonView(
                        iconName: "book.fill",
                        title: "Daily Prophecy Readings"
                    ) {
                        showingProphecyReadings = true
                    }
                }
                
                DataButtonView(
                    iconName: "person.fill",
                    title: "Commemorations"
                ) {
                    // First show the sheet with existing data
                    showingCommemorations = true
                }
                
                
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .sheet(isPresented: $showingEpistleReadings) {
            if let calendarDay = viewModel.calendarDay {
                DailyEpistleSheet(readings: calendarDay.readings)
            } else {
                ProgressView("Loading readings...")
                    .onAppear {
                        viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingGospelReadings) {
            if let calendarDay = viewModel.calendarDay {
                DailyGospelSheet(readings: calendarDay.readings)
            } else {
                ProgressView("Loading readings...")
                    .onAppear {
                        viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingProphecyReadings) {
            if let calendarDay = viewModel.calendarDay {
                DailyProphecySheet(readings: calendarDay.readings)
            } else {
                ProgressView("Loading readings...")
                    .onAppear {
                        viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingCommemorations) {
            if let calendarDay = viewModel.calendarDay {
                CommemorationSheet(stories: calendarDay.stories)
            } else {
                ProgressView("Loading commemorations...")
                    .onAppear {
                        viewModel.loadCalendarDay()
                    }
            }
        }
        .onAppear {
            // Initial load when view appears
            viewModel.loadCalendarDay()
        }
    }
}

#Preview { OrthocalView() }
