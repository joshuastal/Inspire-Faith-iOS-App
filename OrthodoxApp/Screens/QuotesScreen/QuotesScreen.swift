//
//  QuotesScreen.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/25/24.
//

import SwiftUI

struct QuotesScreen: View {
    @ObservedObject var viewModel: QuotesViewModel
    @State private var currentTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom tab indicator
            HStack(spacing: 0) {
                Text("All")
                    .fontWeight(currentTab == 0 ? .bold : .regular)
                    .foregroundColor(currentTab == 0 ? .primary : .secondary)
                    .frame(maxWidth: .infinity)
                
                Rectangle()
                    .frame(width: 1, height: 20)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                
                Text("Favorites")
                    .fontWeight(currentTab == 1 ? .bold : .regular)
                    .foregroundColor(currentTab == 1 ? .primary : .secondary)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            
            
            TabView(selection: $currentTab) {
                AllQuotesView(allQuotes: viewModel.allQuotes, viewModel: viewModel)
                    .tag(0)
                
                
                Group {
                    if viewModel.favoriteQuotes.isEmpty {
                        VStack {
                            Image(systemName: "heart")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                                .padding()
                            Text("No favorites yet")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("Swipe left to see all quotes and add some favorites!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    } else {
                        AllQuotesView(allQuotes: viewModel.favoriteQuotes, viewModel: viewModel)
                    }
                }
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}
