//
//  SubtleGrayReadout.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/3/22.
//

import SwiftUI

struct SubtleGrayReadout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(.top, 2)
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .padding(.bottom, 4)
            .background(Color.gray.opacity(0.5))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

extension View {
    func subtleGrayReadout() -> some View {
        self.modifier(SubtleGrayReadout())
    }
}
