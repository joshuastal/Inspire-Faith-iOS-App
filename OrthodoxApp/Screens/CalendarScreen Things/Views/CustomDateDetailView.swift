import SwiftUI

struct CustomDateDetailView: View {
    let date: Date
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: OrthocalViewModel
    @AppStorage("accentColor") private var accentColor: Color = .blue

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    // Helper computed properties to extract date components
    private var year: Int {
        Calendar.current.component(.year, from: date)
    }
    
    private var month: Int {
        Calendar.current.component(.month, from: date)
    }
    
    private var day: Int {
        Calendar.current.component(.day, from: date)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with close button - more compact
            ZStack {
                        // Centered text
                        Text(formattedDate)
                            .foregroundColor(Color(.label))
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity)
                        
                        // Right-aligned close button
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.spring()) {
                                    isPresented = false
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(.label))
                                    .imageScale(.large)
                                    .frame(width: 44, height: 44)
                            }
                        }
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
            
            ScrollView {
                VStack(spacing: 20) {
                                        
                    // Fasting Block
                    if viewModel.chosenCalendarDay != nil {
                        let fastDetector = FastLevelDetector(orthocalViewModel: viewModel, specificCalendarDay: viewModel.chosenCalendarDay)
                        DefaultContentPill(
                            iconName: "fork.knife",
                            content: "Fast: \(fastDetector.fastTitle)"
                        )
                        .padding(.top, 3)
                        .frame(maxWidth: .infinity) // Make it fill available width
                    }
                    
                    // Tone Block
                    if let tone = viewModel.chosenCalendarDay?.tone {
                        DefaultContentPill(
                            iconName: "music.note",
                            content: "Tone: \(tone)",
                            iconOffset: CGPoint(x: -5, y: 0),
                            textOffset: CGPoint(x: -6, y: 0)
                            // Remove maxWidth parameter to allow full width
                        )
                        .frame(maxWidth: .infinity) // Make it fill available width
                    }
                    
                    // Feast Block
                    if let feasts = viewModel.chosenCalendarDay?.feasts, !feasts.isEmpty {
                        DefaultContentPill(
                            iconName: "party.popper",
                            content: "Feasts: \(feasts.joined(separator: ", \n"))",
                            scalesText: true
                        )
                        .frame(maxWidth: .infinity) // Make it fill available width
                    }
                    
                
                    
                    
                }
                .padding(.horizontal, 16) // Slightly larger horizontal padding
            }
        }
        .task {
            // Load the calendar data when the view appears
            await viewModel.loadChosenCalendarDay(year: year, month: month, day: day)
        }
    }
}
