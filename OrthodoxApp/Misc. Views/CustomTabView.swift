import SwiftUI

struct CustomTabView: View {
    @Binding var currentTab: Int
    var tab1: String
    var tab2: String
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            TabButton(text: tab1, isSelected: currentTab == 0, animation: animation) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    currentTab = 0
                }
            }
            
            TabButton(text: tab2, isSelected: currentTab == 1, animation: animation) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    currentTab = 1
                }
            }
        }
        .padding(4)
        .background(Color(.systemGray6).opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentTab) // Add animation for tab changes
    }
}

struct TabButton: View {
    let text: String
    let isSelected: Bool
    var animation: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .fontWeight(.medium)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.accentColor.opacity(0.15))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .foregroundColor(isSelected ? .accentColor : .secondary)
                .scaleEffect(isSelected ? 1.02 : 1)
        }
        .buttonStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    CustomTabView(currentTab: .constant(0), tab1: "Tab 1", tab2: "Tab 2")
}
