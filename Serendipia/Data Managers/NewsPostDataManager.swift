//
//  NewsPostDataManager.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/3/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import Foundation

class NewsPostDataManager {
	
	static let shared = NewsPostDataManager()
	
	func commentOnPost(comment: String, postId: String, user: User) {
		print("commented: \(comment) on post \"\(postId)\"")
	}
}
