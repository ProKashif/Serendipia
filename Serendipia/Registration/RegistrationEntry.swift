//
//  RegistrationForm.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/10/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

struct RegistrationEntry {
	let field: RegistrationField
	var value: Any?
	
	var isValid: Bool {
		if field.isRequired == false {
			return true
		}
		
		if let _ = value as? UIImage {
			return true
		} else if let text = value as? String {
			return text.count > 0
		}
		
		return false
	}
}
