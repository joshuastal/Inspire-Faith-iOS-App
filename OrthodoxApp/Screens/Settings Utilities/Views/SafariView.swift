//
//  SafariView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//

import SwiftUI

import SafariServices

// Create a UIKit wrapper for SFSafariViewController
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
