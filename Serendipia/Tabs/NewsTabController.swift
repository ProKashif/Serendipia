//
//  NewsTabController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

let addingAnimation = UITableView.RowAnimation.bottom
let removingAnimation = UITableView.RowAnimation.top

class NewsTabController: UIViewController, Refreshable {
	@IBOutlet weak var tableView: UITableView!
	private var expandedSectionIndices = [Int]()
	private var posts = TestPosts().testPosts
	
	func refresh() {
		tableView.reloadData()
	}
}


extension NewsTabController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView.indexPathsForSelectedRows?.compactMap({ $0.section }).contains(section) ?? false {
			return 3 + numberOfCommentsInSection(section)
		} else {
			return 2
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return posts.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let post = posts[indexPath.section]
		var cellId: String = ""
		if indexPath.item == 0 {
			cellId = "postAuthorAndBody"
		} else if indexPath.item == 1 {
			cellId = "likeAndCommentCount"
		} else if itemIsLastInSection(itemIndex: indexPath.item, sectionIndex: indexPath.section) {
			cellId = "commentBox"
		} else {
			cellId = "comment"
		}
		
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
		if let cell = cell as? NewsPostConfiguring {
			cell.configure(newsPost: post)
		} else if let cell = cell as? NewsCommentCell {
   			cell.configure(comment: post.comments[indexPath.item - 2])
		}
		
		if let cell = cell as? NewsCommentBoxCell {
			cell.commentAdded = commentAdded
			cell.textFieldEditingBegan = { [weak self] in
				self?.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
			}
		}
		
		return cell
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		view.endEditing(true)
	}
	
	private func commentAdded(comment: String, postId: String, sender cell: UITableViewCell) {
		guard
			let user = UserManager.shared.loggedInUser,
			let postIndex = sectionIndexForCell(cell, in: tableView)
		else { return }
		
		NewsPostDataManager.shared.commentOnPost(comment: comment, postId: postId, user: user)
		addCommentToTableViewDataSource(Comment(user: user, body: comment, id: nil), sectionIndex: postIndex)
		
	}
	
	private func addCommentToTableViewDataSource(_ comment: Comment, sectionIndex: Int) {
		guard let lastCommentRow = indexPathsForCommentsInSection(sectionIndex).last?.row else { return }
		var post = posts[sectionIndex]
		post.comments.append(comment)
		posts[sectionIndex] = post
		tableView.performBatchUpdates({
			tableView.reloadRows(at: [IndexPath(row: lastCommentRow, section: sectionIndex)], with: .automatic)
			tableView.insertRows(at: [IndexPath(row: lastCommentRow + 1, section: sectionIndex)], with: .automatic)
		}, completion: nil)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView.cellForRow(at: indexPath)?.isKind(of: NewsLikeAndCommentCountCell.self) ?? false {
			showCommentsForSection(indexPath.section)
		}
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if tableView.cellForRow(at: indexPath)?.isKind(of: NewsLikeAndCommentCountCell.self) ?? false {
			hideCommentsForSection(indexPath.section)
		}
	}
	
	private func showCommentsForSection(_ section: Int) {
		let indexPaths = indexPathsForCommentsInSection(section)
		tableView.insertRows(at: indexPaths, with: addingAnimation)
	}
	
	private func hideCommentsForSection(_ section: Int) {
		let indexPaths = indexPathsForCommentsInSection(section)
		tableView.deleteRows(at: indexPaths, with: removingAnimation)
	}
	
	private func indexPathsForCommentsInSection(_ section: Int) -> [IndexPath] {
		// +2 offset for first two non-comment cells, +2 at the end to match it, +1 for the "add comment" text box
		return Array(2..<posts[section].comments.count+3).compactMap { IndexPath(item: $0, section: section) }
	}
	
	private func numberOfCommentsInSection(_ section: Int) -> Int {
		return posts[section].comments.count
	}
	
	private func itemIsLastInSection(itemIndex: Int, sectionIndex: Int) -> Bool {
		return itemIndex == (tableView.numberOfRows(inSection: sectionIndex) - 1)
	}
	
	private func sectionIndexForCell(_ cell: UITableViewCell, in tableView: UITableView) -> Int? {
		return tableView.indexPath(for: cell)?.section
	}
}


