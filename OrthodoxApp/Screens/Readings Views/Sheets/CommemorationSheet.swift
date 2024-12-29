//
//  CommemorationSheet.swift
//  OrthodoxApp
//
//  Created by Joshua Stalinger on 12/28/24.
//

import SwiftUI

struct CommemorationSheet: View {
    
    let stories: [Story]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(stories.indices, id: \.self) { index in
                        let story = stories[index]
                        
                        CommemorationCardView(story: story)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem {
                    Text("Commemorations")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.trailing, 45)
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

#Preview {
    CommemorationSheet(
        stories: [
            Story(
                title: "Preview Story",
                story: "This is a test story about a test. The test was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words."
            ),
            Story(
                title: "Preview Story",
                story: "This is a test story about a test. The test was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words."
            ),
            Story(
                title: "Preview Story",
                story: "This is a test story about a test. The test was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words."
            ),
            Story(
                title: "Preview Story",
                story: "This is a test story about a test. The test was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words. It was very long and involved many words."
            )
        ]
    )
}
