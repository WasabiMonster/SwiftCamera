//
//  ShapeStyle+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/8/22.
//

import SwiftUI

// Useful for debugging Views with
// .background(.random) modifier
extension ShapeStyle where Self == Color {
    static var randomColor: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
