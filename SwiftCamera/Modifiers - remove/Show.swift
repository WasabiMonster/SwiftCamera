//
//  Show.swift
//  Backflip
//
//  Created by Patrick Wilson on 12/13/21.
//

import SwiftUI

struct Show: ViewModifier {
    var show: Bool
    
    public func body(content: Content) -> some View {
        if show {
            content
        } else {
            return EmptyView()
        }
        return EmptyView()
    }
}

extension View {
    public func show(_ show: Bool) -> some View {
        return self.modifier(Show(show: show))
    }
}
