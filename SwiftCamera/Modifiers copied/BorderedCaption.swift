//
//  BorderedCaption.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/2/22.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(Color.blue)
    }
}
