import SwiftUI

struct QuoteCardView: View {
    
    let quote: QuoteObject
    let viewModel: QuotesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Quote text
            Text("\"\(quote.quote)\"")
                .font(.custom("AvenirLTStd-Medium", size: 18))
                .lineSpacing(8) // Added line spacing for better readability
                .multilineTextAlignment(.leading)
                .padding(.top, 16)
            
            // Author with divider
            HStack {
                Divider()
                    .frame(width: 30, height: 1)
                
                Text("- \(quote.author)")
                    .font(.custom("AvenirLTStd-Heavy", size: 18))
                    .foregroundColor(.secondary)
            }
            
            QuoteCardButtonsView (
                viewModel: viewModel,
                quote: quote
            )
            
        }
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
        .frame(maxWidth: .infinity)
        // Being Card Outline
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.label).opacity(0.3), lineWidth: 2)
        )
        // End Card Outline
        .padding(.horizontal)
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    
    QuoteCardView(quote: viewModel.testQuote, viewModel: viewModel)
}
