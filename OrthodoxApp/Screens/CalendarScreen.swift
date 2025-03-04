import SwiftUI

struct InfiniteCalendarScreen: View {
    @StateObject private var viewModel = CalendarViewModel()
    @ObservedObject var orthocalViewModel: OrthocalViewModel
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
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
                            .foregroundColor(accentColor)
                            .frame(width: 44, height: 44)
                            .background(accentColor.opacity(0.1))
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
                            .foregroundColor(accentColor)
                            .frame(width: 44, height: 44)
                            .background(accentColor.opacity(0.1))
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
                .onChange(of: viewModel.currentMonth) { _, newMonth in
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
                CustomDateDetailView(date: selectedDate, isPresented: $viewModel.showingDateDetails, viewModel: orthocalViewModel)
            } else {
                // Fallback if no date is selected (shouldn't happen)
                Text("No date selected")
                    .padding()
            }
        }
    }
}
