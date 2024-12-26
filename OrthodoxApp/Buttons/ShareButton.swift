//
//  ShareButton.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/26/24.
//

import SwiftUI

struct ShareButton: View {
    var sharedQuote: QuoteObject
    var iconSize: CGFloat
    
    var body: some View {
        ShareLink(item: "\"\(sharedQuote.quote)\" \n -\(sharedQuote.author)") {
            Label("", systemImage: "square.and.arrow.up")
                .font(.system(size: iconSize)) // Custom font size
        }
    }
}






#Preview {
    ShareButton(
        sharedQuote: QuoteObject (
            quote: "Lorem ipsum dolor sit amet.",
            author: "Test Quote"
        ),
        iconSize: 40
    )
}
