import SwiftUI

struct QuoteCardView: View {
    
    let quote: QuoteObject
    let viewModel: QuotesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Quote text
            Text("\"\(quote.quote)\"")
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.top, 8)
            
            // Author with divider
            HStack {
                Divider()
                    .frame(width: 30, height: 1)
                
                Text("- \(quote.author)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack{
                VStack{ // Favorites
                    FavoriteButton(quote: quote, viewModel: viewModel)
                    PrintFavorites(viewModel: viewModel)
                    ClearFavorites(viewModel: viewModel)
                }
            }
            
            
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.label).opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    
    QuoteCardView(quote: viewModel.testQuote, viewModel: viewModel)
}
