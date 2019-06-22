//
//  UserManager.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

class UserManager {
	static let shared = UserManager()
	
	private let loggedInUserKey = "loggedInUser"
	var loggedInUserId: String? {
		set {
			UserDefaults.standard.set(newValue, forKey: loggedInUserKey)
		} get {
			return UserDefaults.standard.value(forKey: loggedInUserKey) as? String
		}
	}
}
