import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct ContentView: View {
    let db = Firestore.firestore()
    @StateObject var viewModel = QuotesViewModel()
    @State private var defaultSelection = 1
    
    var body: some View {
        TabView(selection: $defaultSelection) {
            QuotesScreen(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "quote.bubble")
                        .symbolRenderingMode(.monochrome)
                    Text("Quotes")
                }
                .tag(2)
            
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                        .symbolRenderingMode(.monochrome)
                    Text("Home")
                }
                .tag(1)
            
            ReadingsScreen()
                .tabItem {
                    Image(systemName: "book")
                        .symbolRenderingMode(.monochrome)
                    Text("Readings")
                }
                .tag(3)
        }
        .task {
            viewModel.fetchQuotes(db: db)
            print(viewModel.allQuotes)
        }
    }
}
#Preview { ContentView() }


