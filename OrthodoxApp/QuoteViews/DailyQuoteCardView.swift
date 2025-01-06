import SwiftUI

struct DailyQuoteCardView: View {
    let quote: QuoteObject
    let viewModel: QuotesViewModel
    @AppStorage("quoteFontSize") private var quoteFontSize: Double = 18
    
    // Format today's date
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Daily Quote")
                    .font(.custom("AvenirLTStd-Heavy", size: 24))
                    .foregroundColor(.primary)
                    .padding(.top, 12)
                
                Text(formattedDate)
                    .font(.custom("AvenirLTStd-Medium", size: 14))
                    .foregroundColor(.secondary)
                
                Divider()
                    .frame(height: 1)
                    .background(Color(.systemGray4))
            }
            .padding(.bottom, 8)
            
            // Quote Section
            VStack(alignment: .leading, spacing: 16) {
                // Icon and quote
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "quote.opening")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text(quote.quote)
                        .font(.custom("AvenirLTStd-Medium", size: quoteFontSize))
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)
                }
                
                // Author with styling
                HStack {
                    Spacer()
                    Text("— \(quote.author)")
                        .font(.custom("AvenirLTStd-Heavy", size: quoteFontSize))
                        .foregroundColor(.secondary)
                }
            }
            
            // Buttons Section
            QuoteCardButtonsView(
                viewModel: viewModel,
                quote: quote
            )
        }

        // Padding for card content with relation to the outline
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
        .frame(maxWidth: .infinity)
        // Begin Card Outline
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))  // or any color you want
                .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
                .shadow(radius: 2)
        )
        // End Card Outline
        .padding(.horizontal, 8)
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    DailyQuoteCardView(quote: viewModel.testQuote, viewModel: viewModel)
}
