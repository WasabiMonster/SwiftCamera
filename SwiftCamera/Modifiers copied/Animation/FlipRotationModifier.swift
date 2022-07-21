//
//  FlipRotationModifier.swift
//  Backflip
//
//  Created by Patrick Wilson on 4/14/22.
//

import SwiftUI

struct FlipRotationModifier: ViewModifier, Animatable {
	var pct: Double
	var direction: FlipRotationDirection

	var animatableData: Double {
		get { pct }
		set { pct = newValue }
	}

	func body(content: Content) -> some View {
		content
			.rotation3DEffect(
				Angle(degrees: calcRotation()),
				axis: (x: 0.0, y: 1.0, z: 0.0),
				anchor: .center,
				anchorZ: 0,
				perspective: 0.4
			)
	}

	private func calcRotation() -> Double {
		if direction == .left {
			return 90 - (pct * 90)
		} else {
			return -1 * (pct * 90)
		}
	}
}

public enum FlipRotationDirection {
	case left
	case right
}

extension AnyTransition {
	static var flipRotation: AnyTransition {
		return AnyTransition.asymmetric(
				insertion: AnyTransition.modifier(
					active: FlipRotationModifier(
						pct: 0,
						direction: .left
					),
					identity: FlipRotationModifier(
						pct: 1,
						direction: .left
					)
				),
				removal: AnyTransition.modifier(
					active: FlipRotationModifier(
						pct: 1,
						direction: .right
					),
					identity: FlipRotationModifier(
						pct: 0,
						direction: .right)
				)
		)
	}
}
