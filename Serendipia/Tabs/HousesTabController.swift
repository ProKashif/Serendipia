//
//  HousesTabController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import PureLayout
import FSCalendar

protocol ReservationBuilding {
	var reservation: Reservation? { set get }
}

let darkPink = UIColor(red: 0.855, green: 0.255, blue: 0.545, alpha: 1.0)
let lightPink = UIColor(red: 0.96, green: 0.74, blue: 0.859, alpha: 1.0)

class HousesTabController: UIViewController {	
	private lazy var calendar: FSCalendar = {
		return (storyboard?.instantiateViewController(withIdentifier: "calendar").view.subviews.first as? FSCalendar) ?? FSCalendar()
	}()
	
	private var startDate: Date? {
		didSet {
			updateSearchButtonEnabled()
			
			guard let startDate = startDate else { fromDateField.text = nil; return }
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/dd/yyyy"
			fromDateField.text = dateFormatter.string(from: startDate)
		}
	}
	private var endDate: Date? {
		didSet {
			updateSearchButtonEnabled()

			guard let endDate = endDate else { toDateField.text = nil; return }
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/dd/yyyy"
			toDateField.text = dateFormatter.string(from: endDate)
		}
	}

	@IBOutlet weak var fromDateField: UITextField!
	@IBOutlet weak var toDateField: UITextField!
	@IBOutlet weak var searchButton: UIButton!
	@IBOutlet weak var searchLocationField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let calendar = storyboard?.instantiateViewController(withIdentifier: "calendar").view.subviews.first as? FSCalendar else { return }
		self.calendar = calendar
		calendar.delegate = self
		calendar.dataSource = self
		fromDateField.inputView = calendar
		fromDateField.inputAccessoryView = makeCalendarInputAccessoryView(title: "From")
		fromDateField.tintColor = .clear
		
		toDateField.inputView = calendar
		toDateField.inputAccessoryView = makeCalendarInputAccessoryView(title: "To")
		toDateField.tintColor = .clear
		
		NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: searchLocationField, queue: nil) { [weak self] _ in
			self?.updateSearchButtonEnabled()
		}
	}
	
	@IBAction func dismissFirstResponder(_ sender: Any) {
		(view.firstResponder as? UITextField)?.endEditing(true)
	}
	
	@objc private func close() {
		fromDateField.endEditing(true)
		toDateField.endEditing(true)
	}
	
	private func updateSearchButtonEnabled() {
		searchButton.isEnabled =
			startDate != nil &&
			endDate != nil &&
			searchLocationField.text != nil
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if var reservationBuilder = segue.destination as? ReservationBuilding {
			guard
				let startDate = startDate,
				let endDate = endDate
			else { return }
			reservationBuilder.reservation = Reservation(startDate: startDate, endDate: endDate)
		}
	}
}


extension HousesTabController: FSCalendarDelegateAppearance, FSCalendarDataSource {
	
	func minimumDate(for calendar: FSCalendar) -> Date {
		return Date()
	}
	
	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		if let startDate = startDate {
			if date > startDate {
				self.endDate = date
			} else if date == startDate {
				self.endDate = nil
			} else if date < startDate {
				self.startDate = date
				self.endDate = nil
			}
		} else {
			startDate = date
		}
		
		updateSelectedDates(calendar: calendar)
	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		startDate = nil
		endDate = nil
		updateSelectedDates(calendar: calendar)
	}
	
	func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
		guard let startDate = startDate else { return nil }
		
		if date == startDate || date == endDate {
			return darkPink
		}
		
		guard let endDate = endDate else { return nil }
		
		if date.isBetween(startDate, and: endDate, inclusive: false) {
			return lightPink
		}
		
		return nil
	}
	
	private func updateSelectedDates(calendar: FSCalendar) {
		guard let startDate = startDate else {
			deselectAllDates()
			return
		}
		guard let endDate = endDate else {
			deselectAllDates(except: [startDate])
			return
		}

		deselectDatesNotBetween(startDate: startDate, and: endDate, calendar: calendar)
		selectDatesBetween(startDate: startDate, and: endDate, calendar: calendar)
	}
	
	private func deselectDatesNotBetween(startDate: Date, and endDate: Date, calendar: FSCalendar) {
		for date in calendar.selectedDates {
			if date.isBetween(startDate, and: endDate, inclusive: true) == false {
				calendar.deselect(date)
			}
		}
	}
	
	private func selectDatesBetween(startDate: Date, and endDate: Date, calendar: FSCalendar) {
		var dateToSelect = startDate
		while dateToSelect <= endDate {
			calendar.select(dateToSelect)
			if let nextDate = dateToSelect.dayAfter() {
				dateToSelect = nextDate
			} else {
				break
			}
		}
	}
	
	private func deselectAllDates(except leaveSelectedDates: [Date] = []) {
		for date in calendar.selectedDates {
			if leaveSelectedDates.contains(date) == false {
				calendar.deselect(date)
			}
		}
	}

	private func makeCalendarInputAccessoryView(title: String) -> UIView {
		let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
		let titleLabel = UILabel()
		titleLabel.text = title
		let closeButton = UIButton()
		closeButton.setImage(UIImage(named: "close"), for: .normal)
		
		view.addSubview(titleLabel)
		view.addSubview(closeButton)
		
		titleLabel.autoPinEdges(toSuperviewMarginsExcludingEdge: .right)
		closeButton.autoPinEdges(toSuperviewMarginsExcludingEdge: .left)
		
		closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
		
		view.backgroundColor = .white
		
		return view
	}
}

