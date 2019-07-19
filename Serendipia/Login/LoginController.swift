//
//  LoginController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/18/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

struct LoginOption {
	let backgroundColor: UIColor
	let option: LoginOptions
	let icon: UIImage?
}

enum LoginOptions: String {
	case facebook = "Facebook"
	case google = "Google"
	case twitter = "Twitter"
	case serendipia = "Serendipia"
}


class LoginController: UIViewController {
	@IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint?
	@IBOutlet private weak var tableView: UITableView!
	private let dataSource = TestLogins.init().testLoginOptions
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.contentInset.top = 25
		tableView.contentInset.bottom = 20

		let numberOfRows = CGFloat(tableView.numberOfRows(inSection: 0))
		let rowHeight = tableView.rowHeight
		tableViewHeightConstraint?.constant = numberOfRows * rowHeight + tableView.contentInset.top + tableView.contentInset.bottom
	}
}

extension LoginController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count + 1 // +1 for Register button
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard indexPath.row < dataSource.count else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "register", for: indexPath)
			return cell
		}

		let cell = tableView.dequeueReusableCell(withIdentifier: "logIn", for: indexPath)
		
		if let cell = cell as? LoginOptionCell {
			cell.configure(option: dataSource[indexPath.row])
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let option = dataSource[indexPath.row]
		switch option.option {
		case .facebook:
		//TODO: facebook login
			break
		case .google:
		//TODO: google login
			break
		case .twitter:
		//TODO: twitter login
			break
		case .serendipia:
			if let vc = storyboard?.instantiateViewController(withIdentifier: "serendipiaLogin") {
				navigationController?.pushViewController(vc, animated: true)
			}
		}
	}
}
