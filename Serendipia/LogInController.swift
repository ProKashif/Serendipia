//
//  LogInController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/19/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class LogInController: UIViewController {
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	@IBAction func logIn() {
		UserManager.shared.loggedInUserId = "testUser"
		dismiss()
	}
}
