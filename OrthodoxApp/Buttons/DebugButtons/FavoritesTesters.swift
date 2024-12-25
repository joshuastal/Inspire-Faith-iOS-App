//
//  FavoritesTesters.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/21/24.
//
import SwiftUI

struct PrintFavorites: View {
    @ObservedObject var viewModel: QuotesViewModel
    
    var body: some View {
        Button {
            for quote in viewModel.favoriteQuotes {
                print("Quote: \"\(quote.quote)\" - \(quote.author)\n")
            }
            
            if(viewModel.favoriteQuotes.isEmpty) { print("Favorites is empty...") }
            
        } label: {
            Image(systemName: "heart.text.square.fill")
            Text("Print Favorites")
        }
        .padding(5)
    }
}

struct ClearFavorites: View {
    @ObservedObject var viewModel: QuotesViewModel
    
    var body: some View {
        Button {
            if(!viewModel.favoriteQuotes.isEmpty){
                print("Clearing favorites...")
                viewModel.favoriteQuotes.removeAll()
                print(viewModel.favoriteQuotes)
            } else {
                print("Favorites is already empty...")
            }
            
        } label: {
            Image(systemName: "heart.slash")
            Text("Clear Favorites")
        }
        .padding(5)
    }
}
