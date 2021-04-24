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
    private let loggedInUserKey = "loggedInUser"
	func userDidLogIn() {
		if let refreshable = selectedViewController as? Refreshable {
			refreshable.refresh()
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		UserManager.shared.addObserver(self, forKeyPath: loggedInUserKey, options: [], context: nil)
		
		if UserManager.shared.loggedInUser == nil {
			if let logIn = storyboard?.instantiateViewController(withIdentifier: "login") {
				present(logIn, animated: true, completion: nil)
			}
		}
	}
    
    override func viewDidDisappear(_ animated: Bool) {
        UserManager.shared.removeObserver(self, forKeyPath: loggedInUserKey)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard
            keyPath == loggedInUserKey,
            let viewControllers = viewControllers
        else { return }
        
        for vc in viewControllers {
            if let refreshableVC = vc as? Refreshable {
                refreshableVC.refresh()
            }
        }
    }
    
}

