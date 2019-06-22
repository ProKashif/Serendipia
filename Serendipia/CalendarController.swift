//
//  CalendarController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
	var startDate: Date?
	var endDate: Date?
	@IBOutlet weak var calendar: FSCalendar!
	
	func minimumDate(for calendar: FSCalendar) -> Date {
		return Date()
	}
	
	func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
		if startDate == nil {
			startDate = date
		} else if startDate?.timeIntervalSince(date) ?? -1 < 0 {
			return false
		} else {
			selectDates(between: startDate, and: date, forCalendar: calendar)
		}
		
		return true
	}
	
	func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
		if date == startDate {
			startDate = nil
		}
		
		return true
	}
	
	private func selectDates(between startDate: Date?, and endDate: Date?, forCalendar calendar: FSCalendar) {
		guard let startDate = startDate, let endDate = endDate else { return }
		
		var dateToSelect = startDate
		
		while dateToSelect.timeIntervalSince(endDate) < 0 {
			calendar.select(dateToSelect)
			if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: dateToSelect) {
				dateToSelect = nextDate
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		calendar.dataSource = self
		calendar.delegate = self
	}
}
