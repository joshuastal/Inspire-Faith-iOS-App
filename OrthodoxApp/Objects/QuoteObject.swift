import Foundation

struct QuoteObject: Identifiable, Codable, Equatable {
    let id: String
    var quote: String
    var author: String
    
    // If you need custom encoding/decoding, you can add these:
    enum CodingKeys: CodingKey {
        case id
        case quote
        case author
    }
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
        self.id = "\(quote)-\(author)".lowercased()  // Create ID in initializer
    }
    
}
