//
//  PlaceholderStyle.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/8/21.
//

import SwiftUI

public struct SearchPlaceholder: ViewModifier {
    var show: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show {
                Text(placeholder)
                    .customFont(AppFonts.primaryBody, category: .medium)
                    .foregroundColor(Color.neutralGray50)
            }
            content
        }
    }
}
