import SwiftUI


extension OrthocalViewModel {
    var hasProphecyReadings: Bool {
        guard let calendarDay = calendarDay else { return false }
        return calendarDay.readings.contains { reading in
            reading.source.contains("Prophecy")
        }
    }
    
    var otherReadings: Bool {
        guard let calendarDay = calendarDay else { return false }
        return calendarDay.readings.contains { reading in
            let source = reading.source.lowercased()
            // Define main categories to exclude
            let mainCategories = ["epistle", "gospel", "prophecy"]
            // Return true if the source doesn't contain any of the main categories
            return !mainCategories.contains { category in
                source.contains(category)
            }
        }
    }
}

struct OrthocalView: View {
    @StateObject private var viewModel = OrthocalViewModel()
    @State private var showingEpistleReadings = false
    @State private var showingGospelReadings = false
    @State private var showingCommemorations = false
    @State private var showingProphecyReadings = false
    @State private var showingOtherReadings = false
    
    var body: some View {
        ScrollView{
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
                    
                    if viewModel.otherReadings {
                        DataButtonView(
                            iconName: "book.fill",
                            title: "Daily Miscellaneous Readings"
                        ) {
                            showingOtherReadings = true
                        }
                    }
                    
                    DataButtonView(
                        iconName: "person.fill",
                        title: "Commemorations"
                    ) {
                        // First show the sheet with existing data
                        showingCommemorations = true
                    }
                    
                    ReadingPrayerCardView()

                    Spacer()
                }
                .padding(.horizontal, 8)
            
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $showingEpistleReadings) {
            if let calendarDay = viewModel.calendarDay {
                DailyEpistleSheet(readings: calendarDay.readings)
            } else {
                ProgressView("Loading readings...")
                    .task {  // Changed from onAppear
                        await viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingGospelReadings) {
            if let calendarDay = viewModel.calendarDay {
                DailyGospelSheet(readings: calendarDay.readings)
            } else {
                ProgressView("Loading readings...")
                    .task {  // Changed from onAppear
                        await viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingProphecyReadings) {
            if let calendarDay = viewModel.calendarDay {
                DailyProphecySheet(readings: calendarDay.readings)
            } else {
                ProgressView("Loading readings...")
                    .task {  // Changed from onAppear
                        await viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingOtherReadings) {
            if let calendarDay = viewModel.calendarDay {
                let otherReadings = calendarDay.readings.filter { reading in
                    let source = reading.source.lowercased()
                    let mainCategories = ["epistle", "gospel", "prophecy"]
                    return !mainCategories.contains { source.contains($0) }
                }
                DailyOtherSheet(readings: otherReadings)
            } else {
                ProgressView("Loading readings...")
                    .task {
                        await viewModel.loadCalendarDay()
                    }
            }
        }
        .sheet(isPresented: $showingCommemorations) {
            if let calendarDay = viewModel.calendarDay {
                CommemorationSheet(stories: calendarDay.stories)
            } else {
                ProgressView("Loading commemorations...")
                    .task {  // Changed from onAppear
                        await viewModel.loadCalendarDay()
                    }
            }
        }
        .task {  // Changed from onAppear
            await viewModel.loadCalendarDay()
        }
    }
}

#Preview { OrthocalView() }
