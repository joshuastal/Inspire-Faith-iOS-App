//
//  PrayersScreen.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 2/24/25.
//

import Foundation
import SwiftUI

struct PrayersScreen: View {
    // State variable to track selected tabs
    @State private var currentTab = 0
    var tabs: [String] = ["Tab 1", "Tab 2", "Tab 3"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Main tab selector at the top
                PrayerTabView(currentTab: $currentTab, tabs: tabs)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentTab)
                
                // Swipeable area: TabView that changes the selected tab when swiped
                TabView(selection: $currentTab) {
                    ForEach(tabs.indices, id: \.self) { index in
                        VStack {
                            // Replace this with your content for each tab
                            Text("Content for \(tabs[index])")
                                .padding()
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentTab)
                
                Spacer()
            }
            .navigationTitle("🙏🏼 Prayers")
            .background(Color(UIColor.systemBackground))
        }
    }
}

#Preview {
    PrayersScreen()
}
