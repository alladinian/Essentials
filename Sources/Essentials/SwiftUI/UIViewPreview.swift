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
    var schemes: [ColorScheme] = [.light]
    var ignoreEdges: Edge.Set = .all

    public init(view: UIView, displayName: String? = nil, schemes: [ColorScheme] = [.light], ignoreEdges: Edge.Set = .all) {
        self.view        = view
        self.displayName = displayName
        self.schemes     = schemes
        self.ignoreEdges = ignoreEdges
    }

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
