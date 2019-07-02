//
//  NewsUserAndBodyCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class NewsUserAndBodyCell: NewsCell, NewsPostConfiguring {
	@IBOutlet weak var profileNameLabel: UILabel!
	@IBOutlet weak var profileImage: DesignableImageView!
	@IBOutlet weak var bodyTextView: UITextView!
	private var photoUrl: URL?
	
	func configure(newsPost: NewsPost) {
		profileNameLabel.text = newsPost.user.name
		photoUrl = newsPost.user.profilePhotoUrl
		ImageManager.shared.fetchImage(for: newsPost.user.profilePhotoUrl) { [weak self] image, url in
			if url == self?.photoUrl {
				self?.profileImage.image = image
			}
		}
		bodyTextView.text = newsPost.body
	}
	
}
