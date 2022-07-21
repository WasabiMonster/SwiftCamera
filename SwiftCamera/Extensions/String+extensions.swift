//
//  String+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 1/23/22.
//

import Foundation

extension String {
    var urlEncoded: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "~-_."))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }

	var asDecimal: Decimal {
		return Decimal(string: self) ?? 0
	}

	func camelCaseToWords() -> String {
		return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
			return CharacterSet.uppercaseLetters.contains($1)
			? $0 + " " + String($1)
			: $0 + String($1)
		}
	}

	var canBeWholeNumber: Bool {
		if self == "0.0" { return true }
		if let dbl = Double(self) {
			if dbl.isNaN || dbl.isInfinite { return false }
			if dbl / Double(Int(dbl)) == 1 { return true }
		}
		return Int(self) != nil
	}

	/// Additional Meta Data
	var withMeta: String {
		let function = #function
		let file = #file
		let line = #line

		return "\(self) -- \(function) \(file):\(line)"
	}

	/// Convert StaticString to String
	init(_ staticString: StaticString) {
		self = staticString.withUTF8Buffer {
			String(decoding: $0, as: UTF8.self)
		}
	}
    
    /// Phone Numbers
    /// mask example: `+X (XXX) XXX-XXXX`
    func formatAsPhoneNumber(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }

    var trimmedPhoneNumber: String? {
        return self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
    }

    /// Fun stuff
	var sarcasm: String {
		if self.isEmpty { return "Nothing to see here" }
		return self
	}
}
