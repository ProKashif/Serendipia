//
//  RegistrationForm.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/10/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class RegistrationForm {
	private lazy var entries: [RegistrationField: RegistrationEntry] = {
		var entries = [RegistrationField: RegistrationEntry]()
		for field in RegistrationField.allCases {
			entries[field] = RegistrationEntry(field: field, value: nil)
		}
		return entries
	}()

	func validateFields() -> Bool {
		for field in RegistrationField.allCases {
			guard
				let entry = entries[field],
				entry.isValid
			else { return false }
		}
		return true
	}
	
	func setValue(_ value: String, forField field: RegistrationField) {
		guard field != .profilePic else {
			//TODO: handle error
			return
		}
		entries[field]?.value = value
	}
	
	func value(forField field: RegistrationField) -> String? {
		return entries[field]?.value as? String
	}
	
	var profilePic: UIImage? {
		get {
			return entries[.profilePic]?.value as? UIImage
		}
		set {
			entries[.profilePic]?.value = newValue
		}
	}
}
