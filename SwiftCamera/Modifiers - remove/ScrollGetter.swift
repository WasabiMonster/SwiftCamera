//
//  ScrollGetter.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/29/21.
//

import SwiftUI

// todo: Refactor to work like FrameGetter
public struct ScrollGetter: ViewModifier {
    
    static let SCROLL_KEY = "scroll"
    @Binding var yPos: CGFloat // = CGFloat.zero
    
    public func body(content: Content) -> some View {
        content
			.background(GeometryReader {
                Color.clear
					.preference(
						key: ViewOffsetKey.self,
						value: -$0.frame(in: .named(ScrollGetter.SCROLL_KEY)).origin.y
					)
            })
            .onPreferenceChange(ViewOffsetKey.self) {value in
				DispatchQueue.main.async {
					yPos = value
				}
            }
    }
}   

extension View {
    public func scrollGetter(_ yPos: Binding<CGFloat>) -> some View {
        modifier(ScrollGetter(yPos: yPos))
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
