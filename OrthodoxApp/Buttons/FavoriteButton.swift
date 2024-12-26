//
//  ShareButton.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/21/24.
//

import SwiftUI

struct FavoriteButton: View {
    
    var quote: QuoteObject
    @ObservedObject var viewModel: QuotesViewModel
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {  // Add animation to the action
                viewModel.addToFavorites(quote: quote)
            }
        } label: {
            Image(systemName:
                viewModel.favoriteQuotes.contains(where: { $0.quote == quote.quote && $0.author == quote.author })
                ? "heart.fill"
                : "heart"
            )
            .symbolRenderingMode(.palette)
            .resizable()
            .frame(
                width: width,
                height: height
            )
            .foregroundColor(.blue)
            .scaleEffect(viewModel.favoriteQuotes.contains(where: { $0.quote == quote.quote && $0.author == quote.author }) ? 1.1 : 1.0)  // Add scale effect
        }
        .tint(.gray)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: viewModel.favoriteQuotes)  // Animate based on favorites changes
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    
    FavoriteButton(
        quote: viewModel.testQuote,
        viewModel: viewModel,
        width: 24,
        height: 22
    )
}
