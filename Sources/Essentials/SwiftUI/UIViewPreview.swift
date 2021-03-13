#if os(iOS) && canImport(SwiftUI) && canImport(Combine)
import UIKit
import SwiftUI
import Combine

@available(iOS 13.0, *)
public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable

    public func makeUIView(context: Context) -> UIView {
        return view
    }

    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

@available(iOS 13.0, *)
public struct ViewPreview: View {
    let view: UIView
    var displayName: String? = nil
    let schemes: [ColorScheme] = [.light]
    let ignoreEdges: Edge.Set = .all

    public var body: some View {
        ForEach(schemes, id: \.self) { colorScheme in
            UIViewPreview {
                self.view
            }
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName((self.displayName != nil ? (self.displayName! + " - ") : "") + "\(String(describing: colorScheme).capitalized)")
            .previewLayout(.sizeThatFits)
        }
        .edgesIgnoringSafeArea(ignoreEdges)
    }
}
#endif
