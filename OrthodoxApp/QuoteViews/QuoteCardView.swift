import SwiftUI

struct QuoteCardView: View {
    
    let quote: QuoteObject
    let viewModel: QuotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Quote text
            Text("\"\(quote.quote)\"")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.top, 8)
            
            // Author with divider
            HStack {
                Divider()
                    .frame(width: 30, height: 1)
                
                Text("- \(quote.author)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            
            QuoteCardButtonsView (
                viewModel: viewModel,
                quote: quote
            )
            
            
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.label).opacity(0.3), lineWidth: 3)
        )
        .padding(.horizontal)
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    
    QuoteCardView(quote: viewModel.testQuote, viewModel: viewModel)
}
