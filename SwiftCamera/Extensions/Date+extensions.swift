//
//  Date+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 2/28/22.
//

import Foundation

extension Date {
    func toString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

	static var currentTimeTomorrow: Date {
		return Date().sameTimeNextDay()
	}

	static var currentTimeYesterday: Date {
		return Date().sameTimeNextDay(inDirection: .backward)
	}

	func sameTimeNextDay(
		inDirection direction: Calendar.SearchDirection = .forward,
		using calendar: Calendar = .current
	) -> Date {
		let components = calendar.dateComponents(
			[.hour, .minute, .second, .nanosecond],
			from: self
		)

		return calendar.nextDate(
			after: self,
			matching: components,
			matchingPolicy: .nextTime,
			direction: direction
		) ?? Date.now + 1
	}

}
