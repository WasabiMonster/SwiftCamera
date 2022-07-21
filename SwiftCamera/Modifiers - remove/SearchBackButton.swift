//
//  BackButton.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/7/21.
//

import SwiftUI

public struct SearchBackButton: ViewModifier {
    @Binding var flag: Bool

    public func body(content: Content) -> some View {
        HStack {
            if flag {
                Button {
                    // withAnimation {
                        // content.presentation.wrappedValue.dismiss()
                    // }
                } label: {
                    if flag {
                        Image("left-karet")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 6)
                            .foregroundColor(Color.primaryGreen)
                            .onTapGesture { self.flag = false }
                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                            .padding(.horizontal, 8)
                    }
                }
            } else {
                Image("search-icon")
                    .padding(.horizontal, 12)
            }
            content
            Spacer()
        }
    }
}
