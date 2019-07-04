//
//  NewsCommentBoxCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

typealias CommentAddedHandler = (_ comment: String, _ postId: String, _ sender: UITableViewCell) -> ()

class NewsCommentBoxCell: NewsCell, NewsPostConfiguring, UITextFieldDelegate {
	var commentAdded: CommentAddedHandler?
	var newsPost: NewsPost?
	@IBOutlet weak var textField: UITextField!
	
	func configure(newsPost: NewsPost) {
		self.newsPost = newsPost
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		if let comment = textField.text, comment.count > 0, let postId = newsPost?.id {
			commentAdded?(comment, postId, self)
		}
		return true
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		textField.text = nil
	}
}



