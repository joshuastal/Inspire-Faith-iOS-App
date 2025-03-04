//
//  PrayersScreen.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 2/24/25.
//

import Foundation
import SwiftUI

struct PrayersScreen: View {
    var body: some View {
        NavigationView {
                VStack {
                    
                    Image(systemName: "face.smiling.inverse")
                        .font(.system(size: 100))
                        .foregroundColor(.gray)
                        .padding()
                    Text("Coming soon!")
                        .font(.title)
                        .foregroundColor(.gray)
                    Text("Please contact developer with any suggestions.")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }.navigationTitle("🙏🏼 Prayers")

        }
    }
}
