import SwiftUI

// OrthocalView.swift
struct OrthocalView: View {
    @StateObject private var viewModel = OrthocalViewModel()
    @State private var showingReadings = false
    @State private var showingCommemorations = false
    var body: some View {
        
        VStack(spacing: 20) {
            VStack(spacing: 16) {
                
                // Daily Readings
                DataButtonView(
                    iconName: "book.fill",
                    title: "Daily Readings"
                ) {
                    showingReadings = true
                }
                // Daily Readings
                
                DataButtonView(
                    iconName: "person.fill",
                    title: "Commemorations"
                ) {
                    showingCommemorations = true
                }
                
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .sheet(isPresented: $showingReadings) {
            if let calendarDay = viewModel.calendarDay {
                ReadingsSheet(readings: calendarDay.readings)
            }
        }
        .sheet(isPresented: $showingCommemorations) {
            if let calendarDay = viewModel.calendarDay {
                CommemorationSheet(stories: calendarDay.stories)
            }
        }
        .onAppear {
            viewModel.loadCalendarDay()
        }
    }
    
}

#Preview { OrthocalView() }
