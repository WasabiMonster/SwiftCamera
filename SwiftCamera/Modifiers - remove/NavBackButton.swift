//
//  NavBackButton.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/28/21.
//

// deprecate

import SwiftUI

public struct NavBackButton: ViewModifier {
    
    public func body(content: Content) -> some View {
        HStack {
            Button {} label: {
                Image("nav-back")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 6)
                    .foregroundColor(Color.clear)
                    // .onTapGesture { self.flag = false }
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                    .padding(.horizontal, 8)
            }
        }
        content
        Spacer()
    }
}
