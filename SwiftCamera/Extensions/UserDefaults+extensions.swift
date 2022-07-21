//
//  UserDefaults+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 4/22/22.
//

import Foundation

extension UserDefaults {

	static func makeClearedInstance(
		for functionName: StaticString = #function,
		inFile fileName: StaticString = #file
	) -> UserDefaults {
		let className = "\(fileName)".split(separator: ".")[0]
		let testName = "\(functionName)".split(separator: "(")[0]
		let suiteName = "com.dobackflip.Backflip-tests.\(className).\(testName)"

		guard let defaults = self.init(suiteName: suiteName) else { return UserDefaults.standard }
		defaults.removePersistentDomain(forName: suiteName)
		return defaults
	}

}
