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
	
	func isBetween(_ date1: Date, and date2: Date, inclusive: Bool = true) -> Bool {
		if inclusive {
			return self >= date1 && self <= date2
		} else {
			return self > date1 && self < date2
		}
	}
}
