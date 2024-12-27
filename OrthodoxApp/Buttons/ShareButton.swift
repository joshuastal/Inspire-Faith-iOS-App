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
    
    @AppStorage("accentColor") private var accentColor: Color = .blue
    
    var body: some View {
        ShareLink(item: "\"\(sharedQuote.quote)\" \n -\(sharedQuote.author)") {
            // Instead of using Label, we'll use Image directly
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: iconSize))
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(accentColor)
            // Create a ZStack to maintain proper centering of the icon
                .frame(width: 44, height: 44, alignment: .center)
        }
        // Border to show clickable area
        //.border(Color.red.opacity(0.3))
    }
}





#Preview {
    ShareButton(
        sharedQuote: QuoteObject (
            quote: "Lorem ipsum dolor sit amet.",
            author: "Test Quote"
        ),
        iconSize: 20
    )
}
