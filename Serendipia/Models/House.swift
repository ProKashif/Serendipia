//
//  House.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

typealias Price = Float

struct House {
	enum Amenity {
		case laundry
		case wifi
		case snacks
		case cleaning
		
		var icon: UIImage? {
			switch self {
			case .laundry:
				return UIImage(named: "laundry")
			case .wifi:
				return UIImage(named: "wifi")
			case .snacks:
				return UIImage(named: "apple")
			case .cleaning:
				return UIImage(named: "broom")
			}
		}
	}
	let photoUrls: [URL]
	let address: Address
	let id: String
	let title: String
	let coordinates: CLLocationCoordinate2D
	let amenities: [Amenity]
	let description: String
	let manager: User
}



struct Address {
	let city: String
	let houseNumber: String
	let street: String
	var streetAndHouseNumber: String { return "\(houseNumber), \(street)"}
}


struct Room {
	struct Rate {
		let date: Date
		let price: Price
	}
	
	let photoUrls: [URL]
	let rates: [Rate]
	let roomNumber: Int
	let name: String
}


extension Room {
	var cheapestDay: Rate? {
		guard rates.count > 0 else { return nil }
		return rates.reduce(rates[0]) { result, rate -> Rate in
			return result.price < rate.price ? result : rate
		}
	}
}


struct Reservation {
	let startDate: Date
	let endDate: Date
	var length: Int {
		return endDate.interval(ofComponent: .day, fromDate: startDate)
	}
	var taxes: Price?
	var subTotal: Price? {
		return (room?.rates.first?.price ?? 0) * Float(length)
	}
	var grandTotal: Price {
		return (subTotal ?? 0) + (taxes ?? 0)
	}
	var room: Room?
	var house: House?
	
	init(startDate: Date, endDate: Date) {
		self.startDate = startDate
		self.endDate = endDate
	}
}
