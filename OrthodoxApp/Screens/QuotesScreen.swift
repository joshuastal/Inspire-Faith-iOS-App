import SwiftUI

struct QuotesScreen: View {
    @ObservedObject var viewModel: QuotesViewModel
    @State private var currentTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom tab indicator
            CustomTabView(
                currentTab: $currentTab,
                tab1: "All",
                tab2: "Favorites"
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentTab)
            
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
            // Match animation timing with CustomTabView
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentTab)
        }
    }
}

#Preview {
    QuotesScreen(viewModel: {
        let viewModel = QuotesViewModel()
        // Add sample quotes
        viewModel.allQuotes = viewModel.testQuotes
        
        // Add some favorite quotes
        viewModel.favoriteQuotes = [viewModel.allQuotes[0]] // Make the first quote a favorite
        
        return viewModel
    }())
}
