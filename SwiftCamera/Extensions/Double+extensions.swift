//
//  Double+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 1/6/22.
//

import Foundation
import CoreGraphics

extension Double {
    var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "Invalid Currency"
    }

	var asDecimal: Decimal {
		return Decimal(self)
	}

    var toPercent: String {
        return "\(self)%"
    }

    func toString() -> String {
        return String(self)
    }

    func toInt() -> Int {
        return Int(self)
    }

    func toFloat() -> Float {
        return Float(self)
    }

    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }

    func toBool() -> Bool {
        return self != 0
    }

	/// Can drop the decimal point when unnecessary
	func toString(fractionDigits: Int, dropWhenWhole: Bool = false) -> String {
		if dropWhenWhole && floor(self) == self.rounded(toPlaces: fractionDigits) {
			return String(format: "%.\(0)f", self)
		}
        return String(format: "%.\(fractionDigits)f", self)
    }

	/// Rounds the double to decimal places value
	func rounded(toPlaces places: Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}

	/// Converts from one unit to another
	func convert(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> Double {
		return Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
	}
}
