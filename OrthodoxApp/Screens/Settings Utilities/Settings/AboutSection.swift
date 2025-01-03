//
//  ExtractedView.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/27/24.
//

import SwiftUI
import Foundation

struct AboutSection: View {
    
    @Binding var showingAbout: Bool
    @Binding var showingPrivacyPolicy: Bool
    
    var body: some View {
        Section(header: Text("About")) {
            Button("About") {
                showingAbout.toggle()
            }
            .foregroundStyle(Color(.label))
            
            
            Button("Privacy Policy") {
                showingPrivacyPolicy.toggle()
            }
            .foregroundStyle(Color(.label))
        }
    }
}
