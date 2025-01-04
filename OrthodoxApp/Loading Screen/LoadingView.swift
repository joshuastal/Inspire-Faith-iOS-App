import SwiftUI
import Foundation

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cross")
                .font(.system(size: 70))
                .foregroundStyle(.blue)

            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
