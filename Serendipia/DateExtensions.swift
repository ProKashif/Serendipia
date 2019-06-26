//
//  DateExtensions.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

extension Date {
	func dayAfter() -> Date? {
		return Calendar.current.date(byAdding: .day, value: 1, to: self)
	}
	
	func dayBefore() -> Date? {
		return Calendar.current.date(byAdding: .day, value: -1, to: self)
	}
	
	func daysAfter(_ days: Int) -> Date? {
		return Calendar.current.date(byAdding: .day, value: days, to: self)
	}
	
	func isBetween(_ date1: Date, and date2: Date, inclusive: Bool = true) -> Bool {
		if inclusive {
			return self >= date1 && self <= date2
		} else {
			return self > date1 && self < date2
		}
	}
	
	static func rangeString(date1: Date, date2: Date) -> String {
		let startDateFormatter = DateFormatter()
		startDateFormatter.dateFormat = "MMMM d"
		let endDateFormatter = DateFormatter()
		endDateFormatter.dateFormat = "d, yyyy"
		return "\(startDateFormatter.string(from: date1)) to \(endDateFormatter.string(from: date2))"
	}
	
	func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
		let currentCalendar = Calendar.current
		
		guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
		guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
		
		return end - start
	}
}
