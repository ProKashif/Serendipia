//
//  NewsLikeAndCommentCountCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class NewsLikeAndCommentCountCell: NewsCell, NewsPostConfiguring {
	@IBOutlet weak var likeIcon: UIImageView!
	@IBOutlet weak var likeCountLabel: UILabel!
	@IBOutlet weak var commentCountLabel: UILabel!
	
	func configure(newsPost: NewsPost) {
		guard let loggedInUser = UserManager.shared.loggedInUser else { return }
		likeIcon.image = UIImage(named: newsPost.likedByUser(loggedInUser) ? "heart" : "heart_empty")
		likeCountLabel.text = "\(newsPost.likes.count)"
		commentCountLabel.text = "\(newsPost.comments.count) comments"
	}
}

