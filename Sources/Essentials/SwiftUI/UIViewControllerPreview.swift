#if os(iOS) && canImport(SwiftUI) && canImport(Combine)
import UIKit
import SwiftUI
import Combine

@available(iOS 13.0, *)
public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable

    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    public func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
        return
    }
}

@available(iOS 13.0, *)
public struct ControllerPreview: View {
    let controller: UIViewController
    var navigation: Bool = false
    var isNavigationRoot: Bool = false
    var schemes: [ColorScheme] = [.light]
    var ignoreEdges: Edge.Set = .all
    var device: String = "iPhone 11"

    let nav: UINavigationController
    let empty = UIViewController()

    public init(controller: UIViewController, navigation: Bool = false, isNavigationRoot: Bool = false, navController: UINavigationController = UINavigationController(), schemes: [ColorScheme] = [.light], ignoreEdges: Edge.Set = .all, device: String = "iPhone 11") {
        self.controller       = controller
        self.navigation       = navigation
        self.nav              = navController
        self.isNavigationRoot = isNavigationRoot
        self.schemes          = schemes
        self.ignoreEdges      = ignoreEdges
        self.device           = device
    }

    public var body: some View {
        ForEach(schemes.reversed(), id: \.self) { colorScheme in
            UIViewControllerPreview {
                if self.navigation {
                    self.empty.title = ""
                    if isNavigationRoot {
                        self.nav.viewControllers = [self.controller]
                    } else {
                        self.nav.viewControllers = [self.empty, self.controller]
                    }
                    return self.nav
                } else {
                    return self.controller
                }
            }
            .edgesIgnoringSafeArea(self.ignoreEdges)
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("\(self.device) - \(String(describing: colorScheme).capitalized)")
            //.previewLayout(.sizeThatFits)
            .previewDevice(PreviewDevice(rawValue: self.device))
        }
    }
}

#endif
