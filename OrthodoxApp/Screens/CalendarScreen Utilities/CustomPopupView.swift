import SwiftUI

// A popup that uses overlay() instead of ZStack to avoid layout issues
struct OverlayPopupView<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isPresented = false
                        }
                    }
                
                VStack {
                    content
                }
                .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.9)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 5)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(), value: isPresented)
    }
}

// Extension to apply the popup as an overlay
extension View {
    func overlayPopup<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.overlay(
            OverlayPopupView(isPresented: isPresented, content: content)
        )
    }
}
