import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct ContentView: View {
    let db = Firestore.firestore()
    @ObservedObject var quotesViewModel: QuotesViewModel
    @ObservedObject var orthocalViewModel: OrthocalViewModel
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            QuotesScreen(viewModel: quotesViewModel)
                .tabItem {
                    Image(systemName: "quote.bubble")
                        .symbolRenderingMode(.monochrome)
                    Text("Quotes")
                }
                .tag(2)
            
            HomeScreen(
                quotesViewModel: quotesViewModel,
                orthocalViewModel: orthocalViewModel
            )
            .tabItem {
                Image(systemName: "house")
                    .symbolRenderingMode(.monochrome)
                Text("Home")
            }
            .tag(1)
            
            ReadingsScreen()
                .tabItem {
                    Image(systemName: selection == 3 ? "book" : "book.closed")
                        .symbolRenderingMode(.monochrome)
                    Text("Readings")
                }
                .tag(3)
        }
    }
}

//#Preview { ContentView() }


