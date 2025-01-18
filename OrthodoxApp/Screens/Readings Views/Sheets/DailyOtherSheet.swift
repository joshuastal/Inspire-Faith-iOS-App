//
//  DailyGospelSheet.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 1/2/25.
//

import SwiftUI

struct DailyOtherSheet: View {
    let readings: [Reading]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(readings.indices, id: \.self) { index in
                        let reading = readings[index]
                        let reference = reading.display
                            .replacingOccurrences(of: ".", with: ":")
                        
                        // Use ReadingCardView for consistency
                        ReadingCardView(reading: reading, reference: reference)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Daily Miscellaneous Readings")
                        .font(.system(size: 21.5, weight: .bold))
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .imageScale(.large)
                            .frame(width: 44, height: 44)
                    }
                }
            }
        }
    }
}
