//
//  Int+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 1/24/22.
//

import Foundation
import CoreGraphics

extension Int {
    static func createWithDigits(_ count: Int) -> Int {
        if count == 0 { return 0 }
        return Int(pow(10, Double(count - 1)))
    }

	var toString: String {
		return String(self)
	}

    var toDouble: Double {
        return Double(self)
    }

	var asDecimal: Decimal {
		return Decimal(integerLiteral: self)
	}

	var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "Invalid Currency"
    }
    
    var toPercent: String {
        return "\(self)%"
    }
    
    var toPercentage: String {
        return "\(self)%"
    }
    
    var roundedUpToNearest: Int {
        if self == 0 { return 0 }
        if self < 10 { return 10 }
        let multDiv: CGFloat = Double(Int.createWithDigits(self.numberOfDigits))
        if self == Int(multDiv) { return self }
        return Int(ceil(Double(self) / multDiv) * multDiv)
    }

    var roundedDownToNearest: Int {
        if self == 0 { return 0 }
        if self < 10 { return 0 }
        let multDiv: CGFloat = Double(Int.createWithDigits(self.numberOfDigits))
        if self == Int(multDiv) { return self }
        return Int(floor(Double(self) / multDiv) * multDiv)
    }

	var withCommas: String {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		guard let formatted = numberFormatter.string(from: NSNumber(value: self)) else { return "" }
		return formatted
	}

    // Not as granular as formatWithAbbreviation. No decimal.
    // Don't use where accuracy is most important.
    var abbreviated: String {
        // less than 1000, no abbreviation
        if self < .thousand {
            return "\(self)"
        }

        // less than 1 million, abbreviate to thousands
        if self < Self.million {
            return "\(self / Self.thousand)k"
        }

        // less than 1 billion, abbreviate to millions
        if self < Self.billion {
            return "\(self / Self.million)M"
        }

        // less than 1 trillion, abbreviate to billions
        if self < Self.trillion {
            return "\(self / Self.billion)B"
        }

        if self < Self.trillion {
            return "\(self / Self.billion)B"
        }
        
        // Only supports numbers as high as into the Trillions
        return "\(self / Self.trillion)T"
    }

    // Deprecating: Returns $1000k over $1M but is more accurate w/ decimals
    /* var formatWithAbbreviation: String {
        let numFormatter = NumberFormatter()

        typealias Abbreviation = (threshold: Double, divisor: Double, suffix: String)
        let abbreviations: [Abbreviation] = [(0, 1, ""),
                                             (1000.0, 1000.0, "k"),
                                             (1_000_000.0, 1_000_000.0, "M"),
                                             (1_000_000_000.0, 1_000_000_000.0, "B"),
                                             (1_000_000_000_000.0, 1_000_000_000_000.0, "T")
        ]

        let startValue = Double(abs(self))
        let abbreviation: Abbreviation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if startValue < tmpAbbreviation.threshold {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        }()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

        return numFormatter.string(from: NSNumber(value: value)) ?? "Invalid Format"
    } */
}

// Numbers as words
extension Int {
    static var hundred = 100
    static var thousand = 1000
    static var million = 1000000
    static var billion = 1000000000
    static var trillion = 1000000000000
}

// Protocol extension will work with Int, UInt64, Int8 and so on
extension BinaryInteger {
    var digitsAsArray: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }

    var numberOfDigits: Int {
        if self == 0 { return 1 }
        return Int(log10(CGFloat(self)) + 1)
    }
}
