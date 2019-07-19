//
//  MainTabBarController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

protocol Refreshable {
	func refresh()
}

class MainTabBarController: UITabBarController, UserManagerObserver {
	func userDidLogIn() {
		if let refreshable = selectedViewController as? Refreshable {
			refreshable.refresh()
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		UserManager.shared.addObserver(self, forKeyPath: "loggedInUser", options: [], context: nil)
		
		if UserManager.shared.loggedInUser == nil {
			if let logIn = storyboard?.instantiateViewController(withIdentifier: "login") {
				present(logIn, animated: true, completion: nil)
			}
		}
	}
}

