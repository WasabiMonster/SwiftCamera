//
//  AnyTransition+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/8/21.
//

import SwiftUI

struct OpacityModifier: ViewModifier {
    let opacity: Double

    func body(content: Content) -> some View {
        content.opacity(opacity)
    }
}

extension AnyTransition {
    static var opOpacity: AnyTransition {
        .modifier(active: OpacityModifier(opacity: 0),
                  identity: OpacityModifier(opacity: 1))
    }

    // rotating chevron: https://sarunw.com/posts/swiftui-animation/
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .top).combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }

	static var listInsertionInOut: AnyTransition {
		let insertion = AnyTransition.scale(scale: 0.5, anchor: UnitPoint.leading)
			.combined(with: .opacity)
		let removal = AnyTransition.scale(scale: 0.5, anchor: UnitPoint.leading)
			.combined(with: .opacity)
		return .asymmetric(insertion: insertion, removal: removal)
	}
}
