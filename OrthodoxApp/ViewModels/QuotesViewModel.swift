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
            quote: "Success is not final, failure is not fatal: it is the courage to continue that counts.",
            author: "Winston Churchill"
        ),
        QuoteObject(
            quote: "In three words I can sum up everything I've learned about life: it goes on.",
            author: "Robert Frost"
        ),
        QuoteObject(
            quote: "It is during our darkest moments that we must focus to see the light.",
            author: "Aristotle"
        ),
        QuoteObject(
            quote: "Yesterday is history, tomorrow is a mystery, but today is a gift. That is why it is called the present.",
            author: "Alice Morse Earle"
        ),
        QuoteObject(
            quote: "Life is what happens when you're busy making other plans.",
            author: "John Lennon"
        ),
        QuoteObject(
            quote: "I have learned over the years that when one's mind is made up, this diminishes fear; knowing what must be done does away with fear.",
            author: "Rosa Parks"
        ),
        QuoteObject(
            quote: "Do not go where the path may lead, go instead where there is no path and leave a trail.",
            author: "Ralph Waldo Emerson"
        ),
        QuoteObject(
            quote: "The only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle.",
            author: "Steve Jobs"
        ),
        QuoteObject(
            quote: "It is not in the stars to hold our destiny but in ourselves.",
            author: "William Shakespeare"
        ),
        QuoteObject(
            quote: "Twenty years from now you will be more disappointed by the things that you didn't do than by the ones you did do. So throw off the bowlines. Sail away from the safe harbor. Catch the trade winds in your sails. Explore. Dream. Discover.",
            author: "Mark Twain"
        ),
        QuoteObject(
            quote: "Be kind, for everyone you meet is fighting a hard battle.",
            author: "Plato"
        ),
        QuoteObject(
            quote: "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.",
            author: "Maya Angelou"
        ),
        QuoteObject(
            quote: "Success usually comes to those who are too busy to be looking for it.",
            author: "Henry David Thoreau"
        ),
        QuoteObject(
            quote: "The future belongs to those who believe in the beauty of their dreams. Never give up on what you really want to do. The person with big dreams is more powerful than one with all the facts.",
            author: "Eleanor Roosevelt"
        ),
        QuoteObject(
            quote: "It does not matter how slowly you go as long as you do not stop.",
            author: "Confucius"
        ),
        QuoteObject(
            quote: "Everything you've ever wanted is on the other side of fear. Life shrinks or expands in proportion to one's courage. The most difficult thing is the decision to act, the rest is merely tenacity.",
            author: "Amelia Earhart"
        ),
        QuoteObject(
            quote: "You have power over your mind - not outside events. Realize this, and you will find strength.",
            author: "Marcus Aurelius"
        ),
        QuoteObject(
            quote: "The only impossible journey is the one you never begin.",
            author: "Tony Robbins"
        ),
        QuoteObject(
            quote: "Education is not the filling of a pail, but the lighting of a fire. The best way to predict your future is to create it. Intelligence plus character - that is the goal of true education.",
            author: "W.B. Yeats"
        ),
        QuoteObject(
            quote: "What lies behind us and what lies before us are tiny matters compared to what lies within us.",
            author: "Ralph Waldo Emerson"
        ),
        QuoteObject(
            quote: "The greatest glory in living lies not in never falling, but in rising every time we fall. Life is either a daring adventure or nothing at all. Security is mostly a superstition. It does not exist in nature.",
            author: "Helen Keller"
        ),
        QuoteObject(
            quote: "Success is walking from failure to failure with no loss of enthusiasm.",
            author: "Winston Churchill"
        ),
        QuoteObject(
            quote: "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart.",
            author: "Helen Keller"
        ),
        QuoteObject(
            quote: "Tell me and I forget. Teach me and I remember. Involve me and I learn.",
            author: "Benjamin Franklin"
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

