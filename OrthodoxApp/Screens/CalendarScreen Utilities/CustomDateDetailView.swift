import SwiftUI

struct CustomDateDetailView: View {
    let date: Date
    @Binding var isPresented: Bool
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
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
                        Text("Selected Date")
                            .font(.title2.bold())
                        
                        Text(formattedDate)
                            .font(.title3)
                    }
                    .padding(.top, 5)
                    
                    // Smiley face image
                    Image(systemName: "face.smiling.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.yellow.opacity(0.2))
                                .frame(width: 150, height: 150)
                        )
                    
                    // Placeholder for future API data
                    VStack(spacing: 15) {
                        Text("Future calendar data will appear here")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        // Placeholder data examples
                        ForEach(1...8, id: \.self) { index in
                            HStack {
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundColor(.blue)
                                    .frame(width: 30)
                                
                                Text("Example data item \(index)")
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text("Details")
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
}
