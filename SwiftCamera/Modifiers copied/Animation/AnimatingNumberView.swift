//
//  NumberView.swift
//  Backflip
//
//  Created by Patrick Wilson on 11/8/21.
//

import Foundation
import SwiftUI

struct AnimatingCurrencyView: ViewModifier, Animatable {
    var number: Double
    var type: NumberFormatter.Style = .currency

    var animatableData: CGFloat {
        get { CGFloat(number) }
        set { number = newValue }
    }

    func body(content: Content) -> some View {
        Text(String(NumberFormatter.localizedString(from: NSNumber(value: number), number: type)))
    }
}

struct AnimatingAbbrieviatedView: ViewModifier, Animatable {
    var number: Int
	var prefix: String = ""
	var suffix: String = ""

    var animatableData: CGFloat {
        get { CGFloat(number) }
        set { number = Int(newValue) }
    }

    func body(content: Content) -> some View {
		Text("\(self.prefix)\(String(number.abbreviated))\(self.suffix)")
    }
}

struct AnimatingWithCommasView: ViewModifier, Animatable {
	var number: Int
	var prefix: String = ""
	var suffix: String = ""

	var animatableData: CGFloat {
		get { CGFloat(number) }
		set { number = Int(newValue) }
	}

	func body(content: Content) -> some View {
		Text("\(self.prefix)\(number.withCommas)\(self.suffix)")
	}
}

extension View {
    func animatingCurrency(_ number: Double, type: NumberFormatter.Style = .currency) -> some View {
        self.modifier(AnimatingCurrencyView(number: number, type: type))
    }

    func animatingAbbrieviated(
		_ number: Int,
		prefix: String = "",
		suffix: String = ""
	) -> some View {
        self.modifier(AnimatingAbbrieviatedView(
			number: number,
			prefix: prefix,
			suffix: suffix
		))
    }

	func animatingWithCommas(
		_ number: Int,
		prefix: String = "",
		suffix: String = ""
	) -> some View {
		self.modifier(AnimatingWithCommasView(
			number: number,
			prefix: prefix,
			suffix: suffix
		))
	}
}
