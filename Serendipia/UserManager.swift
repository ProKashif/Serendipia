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
	var loggedInUser: User? {
		set {
			if let data = try? PropertyListEncoder().encode(newValue) {
				UserDefaults.standard.set(data, forKey: loggedInUserKey)
			}
		} get {
			guard let data = UserDefaults.standard.value(forKey: loggedInUserKey) as? Data else { return nil }
			return try? PropertyListDecoder().decode(User.self, from: data)
		}
	}
}
