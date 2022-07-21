//
//  ClearButton.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/5/21.
//

import SwiftUI

public struct ClearButton: ViewModifier {
    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            if text != "" {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(Color.primaryGreen)
                    .onTapGesture { self.text = "" }
                    .padding(.horizontal, 8)
            }
        }
    }
}
