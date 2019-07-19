//
//  LoginOptionsCell.swift
//  
//
//  Created by Marty Ulrich on 7/18/19.
//

import UIKit

class LoginOptionCell: UITableViewCell {
	@IBOutlet weak var iconImageView: UIImageView?
	@IBOutlet weak var loginLabel: UILabel?
	@IBOutlet weak var roundedContainer: UIView?
	
	func configure(option: LoginOption) {
		iconImageView?.image = option.icon
		loginLabel?.text = "Log in with \(option.option.rawValue)"
		roundedContainer?.backgroundColor = option.backgroundColor
	}
}
