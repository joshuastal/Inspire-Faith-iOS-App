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
    
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    var body: some View {
        Button {
            
            hapticFeedback(style: .light)
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                viewModel.addToFavorites(quote: quote)
            }
        } label: {
            // Create a container that's at least 44x44
            ZStack {
                // The actual heart icon remains the same size
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
                .foregroundColor(accentColor)
                .scaleEffect(viewModel.favoriteQuotes.contains(where: { $0.quote == quote.quote && $0.author == quote.author }) ? 1.0 : 1.0) // Adjust the 0.95 value as needed
            }
            .frame(
                minWidth: 44,
                minHeight: 44,
                alignment: .center
            )
            // Border to show clickable area
            //.border(Color.red.opacity(0.3))
        }
        .tint(.gray)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: viewModel.favoriteQuotes)
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
