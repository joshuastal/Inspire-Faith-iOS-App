import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct ContentView: View {
    let db = Firestore.firestore()
    @StateObject var quotesViewModel = QuotesViewModel()
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
                quotesViewModel: quotesViewModel)
                .tabItem {
                    Image(systemName: "house")
                        .symbolRenderingMode(.monochrome)
                    Text("Home")
                }
                .tag(1)
            
            ReadingsScreen()
                .tabItem {
                    Image(systemName: selection == 3 ? "book" : "book.closed")                        .symbolRenderingMode(.monochrome)
                    Text("Readings")
                }
                .tag(3)
        }
        .task {
            quotesViewModel.fetchQuotes(db: db)
            print(quotesViewModel.allQuotes)
        }
    }
}
#Preview { ContentView() }


