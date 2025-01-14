import SwiftUI

struct ReadingPrayerCardView: View {
    @AppStorage("readingFontSize") private var readingFontSize: Double = 19 // Add this line
    
    var body: some View {
        VStack() {
            // Header Section
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Prayer Before Reading")
                        .font(.custom("AvenirLTStd-Heavy", size: 24))
                        .foregroundColor(.primary)
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    Image(systemName: "book.fill")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                        .padding(.top, 8)
                }
                
                
                Divider()
                    .frame(height: 1)
                    .background(Color(.systemGray4))
                    .padding(.bottom, 8)
            }
            
            // Prayer Section
            VStack() {
                // Prayer
                    Text("Illumine our hearts, O Master Who lovest mankind, with the pure light of Thy divine knowledge. Open the eyes of our mind to the understanding of Thy gospel teachings. \n\nImplant also in us the fear of Thy blessed commandments, that trampling down all carnal desires, we may enter upon a spiritual manner of living, both thinking and doing such things as are well-pleasing unto Thee. \n\nFor Thou art the illumination of our souls and bodies, O Christ our God, and unto Thee we ascribe glory, together with Thy Father, Who is from everlasting, and Thine all-holy, good, and life-creating Spirit, now and ever and unto ages of ages. \n\nAmen.")
                        .font(.custom("AvenirLTStd-Medium", size: readingFontSize))
                        .lineSpacing(8)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
            }
        }

        // Padding for card content with relation to the outline
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
        .frame(maxWidth: .infinity)
        // Begin Card Outline
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .strokeBorder(Color(.label).opacity(0.075), lineWidth: 2)
                .shadow(radius: 2)
        )
        // End Card Outline
    }
}

#Preview {
    let viewModel = QuotesViewModel()
    ReadingPrayerCardView()
}
