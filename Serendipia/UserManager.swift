//
//  UserManager.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

protocol UserManagerObserver {
	func userDidLogIn()
}

class UserManager: NSObject {
	static let shared = UserManager()
	
	private let loggedInUserKey = "loggedInUser"
	var loggedInUser: User? {
		set {
			willChangeValue(forKey: "loggedInUser")
			guard let newValue = newValue else { UserDefaults.standard.removeObject(forKey: loggedInUserKey); return }
			if let data = try? PropertyListEncoder().encode(newValue) {
				UserDefaults.standard.set(data, forKey: loggedInUserKey)
			}
			didChangeValue(forKey: "loggedInUser")
		} get {
			guard let data = UserDefaults.standard.value(forKey: loggedInUserKey) as? Data else { return nil }
			return try? PropertyListDecoder().decode(User.self, from: data)
		}
	}
	
	//MARK: - Observation
	private var observerSet: Set<AnyHashable> = []
	
	private var observers: [UserManagerObserver] {
		return observerSet.compactMap { $0 as? UserManagerObserver }
	}
	
	func addObserver<O>(_ observer: O) where O : UserManagerObserver, O : Hashable {
		_ = observerSet.insert(observer)
	}
	
	private func notifyUserDidLogIn() {
		for observer in observers {
			DispatchQueue.main.async {
				observer.userDidLogIn()
			}
		}
	}
	//MARK: -
}
