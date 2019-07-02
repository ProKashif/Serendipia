//
//  User.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
	let id: String
	let name: String
	let email: String
	let phoneNumber: String
	let profilePhotoUrl: URL
	
	static func == (lhs: User, rhs: User) -> Bool {
		return lhs.id == rhs.id
	}
}
