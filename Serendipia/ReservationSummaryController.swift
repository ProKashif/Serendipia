//
//  ReservationSummaryController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/25/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class ReservationSummaryController: UIViewController, ReservationBuilding {
	var reservation: Reservation?
	
	@IBOutlet weak var houseLabel: UILabel!
	@IBOutlet weak var datesLabel: UILabel!
	@IBOutlet weak var numberOfNightsLabel: UILabel!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var subTotalLabel: UILabel!
	@IBOutlet weak var taxesLabel: UILabel!
	@IBOutlet weak var grandTotalLabel: UILabel!
	
	@IBOutlet weak var checkoutTapped: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let reservation = reservation {
			configure(reservation: reservation)
		}
	}
	
	func configure(reservation: Reservation) {
		let address = reservation.house?.address
		houseLabel.text = "House: \(address?.city ?? "?"), \(address?.houseNumber ?? "?") \(address?.street ?? "?")"
		datesLabel.text = "Dates: \(Date.rangeString(date1: reservation.startDate, date2: reservation.startDate.daysAfter(reservation.length)!))"
		numberOfNightsLabel.text = "\(reservation.length) nights"
		rateLabel.text = "\(reservation.room?.rates.first?.price ?? 0)/night"
		subTotalLabel.text = "$\(reservation.subTotal ?? 0) USD"
		taxesLabel.text = "$\(reservation.taxes ?? 0) USD"
		grandTotalLabel.text = "$\(reservation.grandTotal) USD"
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let success = segue.destination as? ReservationSuccessController {
			success.configure(confirmationNumber: reservation?.confirmationNumber ?? "123456789")
		}
	}
}
