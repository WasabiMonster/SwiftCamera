//
//  Decimal+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 4/7/22.
//

import Foundation

extension Decimal {

	var toInt: Int {
		return (self as NSDecimalNumber).intValue
	}

	var doubleValue: Double {
		return NSDecimalNumber(decimal: self).doubleValue
	}

	var toString: String {
		return "\(self)"
	}

	var toStringExceptZero: String {
		if self == 0 { return "" }
		return "\(self)"
	}

	var toCurrency: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencySymbol = "$"
		formatter.maximumFractionDigits = 2
		return (formatter.string(for: self)) ?? "Invalid Currency"
	}

	var toPercent: String {
		return "\(self)%"
	}

	mutating func round(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode = .plain) {
		var localCopy = self
		NSDecimalRound(&self, &localCopy, scale, roundingMode)
	}

	func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
		var result = Decimal()
		var localCopy = self
		NSDecimalRound(&result, &localCopy, scale, roundingMode)
		return result
	}

	var isWholeNumber: Bool {
		if isZero { return true }
		if !isNormal { return false }
		var me = self
		var rounded = Decimal()
		NSDecimalRound(&rounded, &me, 0, .plain)
		return self == rounded
	}
}
