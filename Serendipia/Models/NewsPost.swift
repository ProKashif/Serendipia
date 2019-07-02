//
//  NewsPost.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

struct NewsPost {
	let user: User
	let body: String
	let id: String
	let comments: [Comment]
	let likes: [User]
	
	func likedByUser(_ user: User) -> Bool {
		return likes.contains { $0 == user }
	}
}
