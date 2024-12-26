import Foundation
import SwiftUI
import CoreGraphics

struct AllQuotesView: View {
    let allQuotes: [QuoteObject]
    let viewModel: QuotesViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                TabView {
                    ForEach(allQuotes) { quote in
                        QuoteCardView(quote: quote, viewModel: viewModel)
                            .padding(.bottom, (75))
                    }
                    .rotationEffect(.degrees(-90)) // Rotate content
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                }
                .frame(
                    width: proxy.size.height, // Height & width swap
                    height: proxy.size.width
                )
                .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
                .offset(x: proxy.size.width) // Offset back into screens bounds
                .tabViewStyle(
                    PageTabViewStyle(indexDisplayMode: .never)
                )
            }
        }
        
        
    }
}



#Preview {
    let viewModel = QuotesViewModel()
    
    AllQuotesView(allQuotes: viewModel.testQuotes, viewModel: viewModel)
}
