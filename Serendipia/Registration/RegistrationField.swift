//
//  RegistrationFields.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/9/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

enum RegistrationField: CaseIterable {
	case profilePic
	case firstName
	case lastName
	case country
	case dream
	case passions
	case achievements
	case skills
	
	var isRequired: Bool {
		switch self {
		case .firstName, .lastName, .country, .profilePic:
			return true
		default:
			return false
		}
	}
}
