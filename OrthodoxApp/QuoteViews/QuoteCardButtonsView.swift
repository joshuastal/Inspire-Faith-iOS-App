//
//  QuoteCardButtonsView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/26/24.
//
import SwiftUI

struct QuoteCardButtonsView: View {
    @ObservedObject var viewModel: QuotesViewModel
    var quote: QuoteObject
    
    var body: some View {
        
        HStack {
            VStack{ // Buttons
                FavoriteButton(
                    quote: quote,
                    viewModel: viewModel,
                    width: 24,
                    height: 22
                )
                .padding(10)
                //PrintFavorites(viewModel: viewModel)
                //ClearFavorites(viewModel: viewModel)
            }
            
            Spacer()
            
            VStack {
                ShareButton(
                    sharedQuote: quote,
                    iconSize: 24
                ).padding(.bottom, 8)
            }
        }
    }
}

