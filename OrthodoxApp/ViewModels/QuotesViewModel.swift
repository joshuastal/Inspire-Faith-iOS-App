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
    
    @AppStorage("savedUnshuffledQuotes") private var savedUnshuffledQuotesData: Data = Data()
    @Published var unshuffledQuotes: [QuoteObject] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(unshuffledQuotes) {
                savedUnshuffledQuotesData = encoded
            }
        }
    }
    
    @AppStorage("savedFavorites") private var savedFavoritesData: Data = Data()
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
        
        self.unshuffledQuotes = self.firestoreQuotes + self.localQuotes

        
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
    
    
    
    
    
    
    
    @AppStorage("currentQuoteIndex") private var currentQuoteIndex: Int = 0
    
    func getDailyQuote(for date: Date = Date()) -> QuoteObject {
        print("Getting quote for date: \(date)")
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: date)
        
        // Check if we need to increment the index for a new day
        if let lastDate = defaults.object(forKey: "lastQuoteDate") as? Date {
            let lastDateStart = calendar.startOfDay(for: lastDate)
            if lastDateStart < today {
                // It's a new day, increment the index
                currentQuoteIndex = (currentQuoteIndex + 1) % unshuffledQuotes.count
                print("New day detected - incrementing index to: \(currentQuoteIndex)")
            }
        }
        
        let daysFromToday = calendar.dateComponents([.day], from: today, to: targetDate).day ?? 0
        let targetIndex = (currentQuoteIndex + daysFromToday) % unshuffledQuotes.count
        
        let quote = unshuffledQuotes[targetIndex]
        
        // If it's today, update cache
        if daysFromToday == 0 {
            if let encoded = try? JSONEncoder().encode(quote) {
                defaults.set(encoded, forKey: "dailyQuote")
                defaults.set(date, forKey: "lastQuoteDate")
            }
        }
        
        print("Returning quote for index \(targetIndex): \(quote.quote)")
        return quote
    }
    
    
    @MainActor
    func updateDailyQuote() {
        dailyQuote = getDailyQuote()
    }
    
}

