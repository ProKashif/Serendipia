//
//  NewsLikeAndCommentCountCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class NewsLikeAndCommentCountCell: NewsCell, NewsPostConfiguring {
	@IBOutlet weak var likeIcon: UIButton!
	@IBOutlet weak var likeCountLabel: UILabel!
	@IBOutlet weak var commentCountLabel: UILabel!
	private var post: NewsPost?
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		selectionStyle = .default
	}
	
	func configure(newsPost: NewsPost) {
		guard let loggedInUser = UserManager.shared.loggedInUser else { return }
		post = newsPost
		likeIcon.setImage(UIImage(named: newsPost.likedByUser(loggedInUser) ? "heart" : "heart_empty"), for: .normal)
		likeCountLabel.text = "\(newsPost.likes.count)"
		commentCountLabel.text = "\(newsPost.comments.count) comments"
	}
	
	@IBAction func likeTapped() {
		if var post = post, let user = UserManager.shared.loggedInUser {
			if post.likedByUser(user) {
				post.unlikeForUser(user)
			} else {
				post.likeForUser(user)
			}
			
			configure(newsPost: post)
		}
	}
}

