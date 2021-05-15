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
    @State private var isDragging: Bool   = false
    @State private var delta: CGSize     = .zero
    @State private var dragOffset: CGSize = .zero

    @Binding public var offset: CGSize?
    public var axis: [Axis] = [Axis.horizontal, Axis.vertical]
    public var onOffsetChange: ((CGSize) -> Void)?

    var resolvedOffset: CGSize {
        var offset = self.delta
        if !axis.contains(.horizontal) {
            offset.width = 0
        }
        if !axis.contains(.vertical) {
            offset.height = 0
        }
        return offset
    }

    public func body(content: Content) -> some View {
        let drag = DragGesture().onChanged { (value) in
            delta      = dragOffset + value.translation
            offset     = delta
            onOffsetChange?(delta)
            isDragging = true
        }.onEnded { (value) in
            isDragging = false
            delta      = dragOffset + value.translation
            offset     = delta
            onOffsetChange?(delta)
            dragOffset = delta
        }
        return content.offset(resolvedOffset).gesture(drag)
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
        content().modifier(Draggable(offset: .constant(nil)))
    }

}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    func draggable(offset: Binding<CGSize?> = .constant(nil), axis: [Axis] = [.horizontal, .vertical]) -> some View {
        modifier(Draggable(offset: offset, axis: axis))
    }

    func draggable(axis: [Axis] = [.horizontal, .vertical], onOffsetChange: ((CGSize) -> Void)? = nil) -> some View {
        modifier(Draggable(offset: .constant(nil), axis: axis, onOffsetChange: onOffsetChange))
    }
}
#endif
