import Foundation
import SwiftUI
import CoreGraphics

struct AllQuotesView: View {
    let allQuotes: [QuoteObject]
    let viewModel: QuotesViewModel
    
    @State private var lastTapTime: Date = Date()
    @State private var currentQuoteIndex: Int = 0
    @State private var isSharing: Bool = false  // Track sharing state
    
    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $currentQuoteIndex) {
                ForEach(Array(allQuotes.enumerated()), id: \.element.id) { index, quote in
                    QuoteCardView(quote: quote, viewModel: viewModel)
                        .padding(.bottom, 75)
                        .tag(index)
                }
                .rotationEffect(.degrees(-90))
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height
                )
            }
            .frame(
                width: proxy.size.height,
                height: proxy.size.width
            )
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                // Reset TabView state when appearing
                if isSharing {
                    isSharing = false
                }
            }
        }
    }
}




#Preview {
    let viewModel = QuotesViewModel()
    
    AllQuotesView(allQuotes: viewModel.testQuotes, viewModel: viewModel)
}
