//
//  ReversingXOffset.swift
//  Backflip
//
//  Created by Patrick Wilson on 4/14/22.
//

import SwiftUI

struct ReversingXOffset: ViewModifier, Animatable {
	var value: CGFloat

	private var target: CGFloat
	private var onEnded: () -> ()

	init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
		self.target = value
		self.value = value
		self.onEnded = onEnded
	}

	var animatableData: CGFloat {
		get { value }
		set { value = newValue
			// animation ends when equal again
			if newValue == target { onEnded() }
		}
	}

	func body(content: Content) -> some View {
		content.offset(x: value)
	}
}

extension View {
	public func reversingXOffset(to value: CGFloat, onEnded: @escaping () -> () = {}) -> some View {
		return self.modifier(ReversingXOffset(to: value, onEnded: onEnded))
	}
}
