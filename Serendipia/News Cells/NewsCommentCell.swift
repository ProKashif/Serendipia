//
//  NewsCommentCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsCommentCell: NewsCell {
	@IBOutlet weak var commentTextView: UITextView!
	@IBOutlet weak var profileImage: UIImageView!
	
	private var comment: Comment?
	
	func configure(comment: Comment) {
		self.comment = comment
		
		let attributedComment = NSMutableAttributedString(string: comment.user.name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
		attributedComment.append(NSAttributedString(string: "\n\(comment.body)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light)]))
		commentTextView.attributedText = attributedComment
//		ImageManager.shared.fetchImage(for: comment.user.profilePhotoUrl) { [weak self] image, url in
//			guard url == comment.user.profilePhotoUrl else {
//				self?.profileImage.image = UIImage(named: "profileIcon")
//				return
//			}
//
//			self?.profileImage.image.
//		}
		profileImage.af_setImage(withURL: comment.user.profilePhotoUrl, placeholderImage: UIImage.profileIcon)
	}
}


