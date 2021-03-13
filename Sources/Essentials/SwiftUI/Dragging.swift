//
//  Dragging.swift
//  NodeFlowKit
//
//  Created by Vasilis Akoinoglou on 11/10/19.
//  Copyright © 2019 Vasilis Akoinoglou. All rights reserved.
//

#if canImport(SwiftUI) && canImport(Combine)
import SwiftUI
import Combine

// MARK: - Modifier Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Draggable: ViewModifier {
    @State var isDragging: Bool = false

    @State var offset: CGSize = .zero
    @State var dragOffset: CGSize = .zero

    public func body(content: Content) -> some View {
        let drag = DragGesture().onChanged { (value) in
            offset     = dragOffset + value.translation
            isDragging = true
        }.onEnded { (value) in
            isDragging = false
            offset     = dragOffset + value.translation
            dragOffset = offset
        }
        return content.offset(offset).gesture(drag)
    }
}

// MARK: - ViewBuilder Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DraggableView<Content>: View where Content: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content().modifier(Draggable())
    }

}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    func draggable() -> some View {
        modifier(Draggable())
    }
}
#endif
