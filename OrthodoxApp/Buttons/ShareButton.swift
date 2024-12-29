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
    @State private var isSharing: Bool = false  // Track if the share sheet is active

    var body: some View {
        Button(action: {
            isSharing = true  // Mark as sharing
            presentShareSheet()
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: iconSize))
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(accentColor)
                .frame(width: 44, height: 44, alignment: .center)
        }
        
    }

    private func presentShareSheet() {
        let shareText = "\"\(sharedQuote.quote)\" \n -\(sharedQuote.author)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true) {
                isSharing = false  // Reset after the share sheet is dismissed
            }
        }
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
