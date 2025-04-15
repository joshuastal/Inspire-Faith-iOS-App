//
//  CalendarDataView.swift
//  Inspire Faith
//
//  Created by Joshua Stalinger on 3/4/25.
//
import SwiftUI

struct CalendarDataView: View {
    let content: String
    let tagColor: Color

    var body: some View {
        HStack {
            // Colored tag
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 8)
                    .fill(tagColor)
                    .frame(width: 5, height: geometry.size.height)
            }
            .frame(width: 5)

            VStack(alignment: .leading) {
                Text("\(content)")
                    .font(.system(size: 16))
                    .padding(.vertical, 2)
            }

            Spacer()
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
        )
        .cornerRadius(8)
        .shadow(radius: 1)
        .padding(.horizontal, 2)
        .padding(.vertical, 4)
    }
}
