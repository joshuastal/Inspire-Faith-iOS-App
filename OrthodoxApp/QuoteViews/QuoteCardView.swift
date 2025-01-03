import SwiftUI

struct QuoteCardView: View {
    
    let quote: QuoteObject
    let viewModel: QuotesViewModel
    @AppStorage("quoteFontSize") private var quoteFontSize: Double = 18  // Add this line
        
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Quote text
            Text("\"\(quote.quote)\"")
                .font(.custom("AvenirLTStd-Medium", size: quoteFontSize))
                .lineSpacing(8) // Added line spacing for better readability
                .multilineTextAlignment(.leading)
                .padding(.top, 16)
            
            // Author with divider
            HStack {
                Spacer()
                
                Text("— \(quote.author)")
                    .font(.custom("AvenirLTStd-Heavy", size: quoteFontSize))
                    .foregroundColor(.secondary)
            }
            
            QuoteCardButtonsView (
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
        )
        // End Card Outline
        .padding(.horizontal)
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    
    QuoteCardView(quote: viewModel.testQuote, viewModel: viewModel)
}
