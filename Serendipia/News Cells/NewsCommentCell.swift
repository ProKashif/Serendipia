//
//  NewsCommentCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class NewsCommentCell: NewsCell {
	@IBOutlet weak var commentTextView: UITextView!
	@IBOutlet weak var profileImage: UIImageView!
	
	private var comment: Comment?
	
	func configure(comment: Comment) {
		self.comment = comment
		
		commentTextView.text = "\(comment.user.name)\n\(comment.body)"
		ImageManager.shared.fetchImage(for: comment.user.profilePhotoUrl) { [weak self] image, url in
			guard url == comment.user.profilePhotoUrl else {
				self?.profileImage.image = UIImage(named: "profileIcon")
				return
			}
			
			self?.profileImage.image = image
		}
	}
}


