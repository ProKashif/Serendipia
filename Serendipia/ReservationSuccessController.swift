//
//  ReservationSuccessController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/25/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class ReservationSuccessController: UIViewController {
	@IBOutlet weak var confirmationNumberLabel: UILabel!
	private var confirmationNumber: String?
	
	func configure(confirmationNumber: String) {
		self.confirmationNumber = confirmationNumber
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		confirmationNumberLabel.text = "Confirmation Number: \(confirmationNumber ?? "0")"
	}
}
