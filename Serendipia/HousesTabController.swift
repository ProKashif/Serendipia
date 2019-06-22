//
//  HousesTabController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import PureLayout

class HousesTabController: UIViewController {
	private var calendarView: UIView?
	
	@IBOutlet weak var fromDateField: UITextField!
	@IBOutlet weak var toDateField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		calendarView = storyboard?.instantiateViewController(withIdentifier: "calendar").view
		fromDateField.inputView = calendarView
		toDateField.inputView = calendarView
		fromDateField.inputAccessoryView = makeCalendarInputAccessoryView(title: "From")
		toDateField.inputAccessoryView = makeCalendarInputAccessoryView(title: "To")
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
	
	@IBAction func dismissFirstResponder(_ sender: Any) {
		(view.firstResponder as? UITextField)?.endEditing(true)
	}
	
	@objc private func close() {
		fromDateField.endEditing(true)
		toDateField.endEditing(true)
	}
}
