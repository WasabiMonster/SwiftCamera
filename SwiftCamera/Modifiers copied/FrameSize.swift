//
//  FrameSize.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/9/22.
//
//  Useful drawn box for debugging views

import SwiftUI

extension View {
    func frameSize(color: Color = .blue) -> some View {
        modifier(FrameSize(color: color))
    }
}

private struct FrameSize: ViewModifier {
    var color: Color = .blue

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader(content: overlay(for:)))
    }

    func overlay(for geometry: GeometryProxy) -> some View {
        ZStack(
            alignment: Alignment(
                horizontal: .trailing,
                vertical: .top
            )
        ) {
            Rectangle()
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 1, dash: [5])
                )
                .foregroundColor(color)
            Text("\(Int(geometry.size.width))x\(Int(geometry.size.height))")
                .font(.caption2)
                .foregroundColor(color)
                .padding(2)
        }
    }
}
