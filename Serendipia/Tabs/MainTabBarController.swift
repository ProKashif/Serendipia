//
//  MainTabBarController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if UserManager.shared.loggedInUser == nil {
			if let logIn = storyboard?.instantiateViewController(withIdentifier: "logIn") {
				present(logIn, animated: true, completion: nil)
			}
		}
	}
}
