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
            
            VStack {
                ShareButton(
                    sharedQuote: quote,
                    iconSize: 20
                )
            }
           
            
            Spacer()
            
            VStack{ // Buttons
                FavoriteButton(
                    quote: quote,
                    viewModel: viewModel,
                    width: 22,
                    height: 20
                )
            }
            
        }
    }
}

