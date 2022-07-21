//
//  CGFloat+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 5/11/22.
//

import CoreGraphics

extension CGFloat {
	func roundToTens() -> CGFloat {
		return 10 * (self / 10.0).rounded()
	}
}
