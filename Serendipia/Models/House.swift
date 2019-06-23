//
//  House.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation
import CoreLocation

typealias Price = Float

struct House {
	let photoUrls: [URL]
	let address: Address
	let rooms: [Room]
	let id: String
	let title: String
	let coordinates: CLLocationCoordinate2D
}

struct Address {
	let city: String
	let houseNumber: String
	let street: String
}


struct Room {
	struct Rate {
		let date: Date
		let price: Price
	}
	
	let rates: [Rate]
	let roomNumber: Int
}


extension Room {
	var cheapestDay: Rate? {
		guard rates.count > 0 else { return nil }
		return rates.reduce(rates[0]) { result, rate -> Rate in
			return result.price < rate.price ? result : rate
		}
	}
}
