import Foundation
import SwiftUI
import FirebaseFirestore

@MainActor
class QuotesViewModel: ObservableObject {
    @Published var firestoreQuotes: [QuoteObject] = []
    @Published var localQuotes: [QuoteObject] = []
    
    
    
    @Published private(set) var dailyQuote: QuoteObject?
    private let defaults = UserDefaults.standard
    
    
    
    @AppStorage("savedAllQuotes") private var savedAllQuotesData: Data = Data()
    @Published var allQuotes: [QuoteObject] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(allQuotes) {
                savedAllQuotesData = encoded
            }
        }
    }
    
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
        
        if let decoded = try? JSONDecoder().decode([QuoteObject].self, from: savedAllQuotesData) {
            allQuotes = decoded
        }
    }
    
    func getDailyQuote() -> QuoteObject {
        print("Starting getDailyQuote")
        
        // Try to get existing quote and date from UserDefaults
        if let savedQuoteData = defaults.data(forKey: "dailyQuote"),
           let savedDate = defaults.object(forKey: "lastQuoteDate") as? Date,
           let savedQuote = try? JSONDecoder().decode(QuoteObject.self, from: savedQuoteData),
           Calendar.current.isDateInToday(savedDate) {
            print("Using existing quote from today")
            // Return the saved quote without updating state
            return savedQuote
        }
        
        // Get quote from storage or generate new one
        let quote = getOrGenerateQuote()
        
        // Save everything to UserDefaults
        if let encoded = try? JSONEncoder().encode(quote) {
            defaults.set(encoded, forKey: "dailyQuote")
            defaults.set(Date(), forKey: "lastQuoteDate")
        }
        
        return quote
    }

    // Add a separate function to update the published state
    func updateDailyQuote() {
        Task { @MainActor in
            dailyQuote = getDailyQuote()
        }
    }

    private func getOrGenerateQuote() -> QuoteObject {
        print("Starting getOrGenerateQuote")
        print("allQuotes count: \(allQuotes.count)")
        
        guard !allQuotes.isEmpty else {
            return QuoteObject(quote: "No quote", author: "Error")
        }
        
        let newQuote = allQuotes.randomElement()!
        print("Selected new quote: \(newQuote.quote)")
        return newQuote
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
    
    func fetchQuotes(db: Firestore) async throws {
            let snapshot = try await db.collection("Quotes").getDocuments()
            
            var counter = 0
            
            self.firestoreQuotes = snapshot.documents.map { doc in
                counter += 1
                let data = doc.data()
                return QuoteObject(
                    quote: data["Quote"] as? String ?? "",
                    author: data["Author"] as? String ?? ""
                )
            }
            
            self.allQuotes = (self.firestoreQuotes + self.localQuotes).shuffled()
            print("\(counter) quotes fetched from Firestore")
            print("\(self.allQuotes.count) quotes in total")
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

