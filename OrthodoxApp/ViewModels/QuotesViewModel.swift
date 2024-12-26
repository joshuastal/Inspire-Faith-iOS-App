import Foundation
import SwiftUI
import FirebaseFirestore

class QuotesViewModel: ObservableObject {
    @Published var firestoreQuotes: [QuoteObject] = []
    @Published var localQuotes: [QuoteObject] = []
    @Published var allQuotes: [QuoteObject] = []
    
    // Create AppStorage for favorites
        @AppStorage("savedFavorites") private var savedFavoritesData: Data = Data()
        
        // Create published property that syncs with AppStorage
        @Published var favoriteQuotes: [QuoteObject] = [] {
            didSet {
                // When favoriteQuotes changes, encode and save to AppStorage
                if let encoded = try? JSONEncoder().encode(favoriteQuotes) {
                    savedFavoritesData = encoded
                }
            }
        }
        
        init() {
            // Load favorites from AppStorage when initializing
            if let decoded = try? JSONDecoder().decode([QuoteObject].self, from: savedFavoritesData) {
                favoriteQuotes = decoded
            }
        }
    
    
    func addToFavorites(quote: QuoteObject) {
        if !favoriteQuotes.contains(where: { $0.id == quote.id }) {
            favoriteQuotes.append(quote)
            print("Added to favorites...")
        } else {
            favoriteQuotes.removeAll(where: { $0.id == quote.id })
            print("Removed from favorites...")
        }
    }
    
    func fetchQuotes(db: Firestore) {
        
        var counter = 0
        
        db.collection("Quotes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching quotes: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            DispatchQueue.main.async {
                self.firestoreQuotes = documents.map { doc in
                    counter += 1
                    let data = doc.data()
                    return QuoteObject(
                        quote: data["Quote"] as? String ?? "",
                        author: data["Author"] as? String ?? ""
                    )
                }

                self.allQuotes = (self.firestoreQuotes + self.localQuotes).shuffled()
                // Omitted self.favoriteQuotes because they were being added twice
                
                print("\(counter) quotes fetched from Firestore")
                print("\(self.allQuotes.count) quotes in total")

            }
        }
    }
    
    let testQuote = QuoteObject(
        quote: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        author: "Test Author"
    )
    
    let testQuotes = [
        QuoteObject(
            quote: "Be yourself; everyone else is already taken.",
            author: "Oscar Wilde"
        ),
        QuoteObject(
            quote: "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.",
            author: "Albert Einstein"
        ),
        QuoteObject(
            quote: "Be the change you wish to see in the world.",
            author: "Mahatma Gandhi"
        )
    ]
}

