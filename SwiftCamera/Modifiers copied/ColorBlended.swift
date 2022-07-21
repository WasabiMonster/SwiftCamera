//
//  ColorBlended.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/29/21.
//

import SwiftUI

/// It's best to place this modifier above it's parent's frame
public struct ColorBlended: ViewModifier {
  fileprivate var color: Color
  
  public func body(content: Content) -> some View {
    VStack {
      ZStack {
        content
        color.blendMode(.sourceAtop)
      }
      .drawingGroup(opaque: false)
    }
  }
}

extension View {
  public func blending(color: Color) -> some View {
    modifier(ColorBlended(color: color))
  }
}
