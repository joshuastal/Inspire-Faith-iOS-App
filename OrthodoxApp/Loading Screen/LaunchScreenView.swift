import SwiftUI
import UIKit

struct LaunchScreenView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Launch Screen", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController")
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed for a static view
    }
}
