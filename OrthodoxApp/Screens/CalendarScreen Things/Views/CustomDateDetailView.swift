import SwiftUI

struct CustomDateDetailView: View {
    let date: Date
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: OrthocalViewModel
    @AppStorage("accentColor") private var accentColor: Color = .blue

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
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
            .padding(.top, 8)
            .padding(.trailing, 8)
            
            ScrollView {
                VStack(spacing: 25) {
                    // Date display with title
                    VStack(spacing: 5) {
                        Text(formattedDate)
                            .font(.title2.bold())
                    }
                    .padding(.top, 5)
                    
                    // Fasting Block
                    if viewModel.chosenCalendarDay != nil {
                        let fastDetector = FastLevelDetector(orthocalViewModel: viewModel, specificCalendarDay: viewModel.chosenCalendarDay)
                        HomePill(
                            iconName: "fork.knife",
                            content: "Fast: \(fastDetector.fastTitle)"
                        )
                    }
                    
                    // Tone Block
                    if let tone = viewModel.chosenCalendarDay?.tone {
                        HomePill (
                            iconName: "music.note",
                            content: "Tone: \(tone)",
                            iconOffset: CGPoint(x: -5, y: 0),
                            textOffset: CGPoint(x: -6, y: 0),
                            maxWidth: 150
                        )
                    }
                    
                    // Feast Block
                    if let feasts = viewModel.chosenCalendarDay?.feasts, !feasts.isEmpty {
                        HomePill(
                            iconName: "party.popper",
                            content: "Feasts: \(feasts.joined(separator: ", \n"))",
                            scalesText: true
                        )
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .task {
            // Load the calendar data when the view appears
            await viewModel.loadChosenCalendarDay(year: year, month: month, day: day)
        }
    }
}
