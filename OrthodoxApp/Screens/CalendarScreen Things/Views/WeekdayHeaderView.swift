//
//  WeekdayHeaderView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/3/25.
//
import SwiftUI
import Foundation

struct WeekdayHeaderView: View {
    private let days = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}
