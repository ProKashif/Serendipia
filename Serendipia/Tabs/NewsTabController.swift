//
//  NewsTabController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/21/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class NewsTabController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	private var expandedSectionIndex: Int? = nil
	private var posts = testPosts
}


extension NewsTabController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if expandedSectionIndex == section {
			return 3 + numberOfCommentsInSection(section)
		} else {
			return 2
		}
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
			cell.configure(comment: post.comments[indexPath.item])
		}
		
		return cell

	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return posts.count
	}
	
	private func numberOfCommentsInSection(_ section: Int) -> Int {
		return posts[section].comments.count
	}
	
	private func itemIsLastInSection(itemIndex: Int, sectionIndex: Int) -> Bool {
		return itemIndex == (tableView.numberOfRows(inSection: sectionIndex) - 1)
	}
}


let testPosts = [
	NewsPost(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
			 id: "1",
			 comments: [
				Comment(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome comment", id: "1"),
				Comment(user: User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
				Comment(user: User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
				Comment(user: User(id: "4", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "awesome comment", id: "4"),
				Comment(user: User(id: "5", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
		], likes: [
			User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!)
		]),
	NewsPost(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
			 id: "1",
			 comments: [
				Comment(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome comment", id: "1"),
				Comment(user: User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
				Comment(user: User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
				Comment(user: User(id: "4", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "awesome comment", id: "4"),
				Comment(user: User(id: "5", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
		], likes: [
			User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!)
		]),
	NewsPost(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
			 id: "1",
			 comments: [
				Comment(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome comment", id: "1"),
				Comment(user: User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
				Comment(user: User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
				Comment(user: User(id: "4", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "awesome comment", id: "4"),
				Comment(user: User(id: "5", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
		], likes: [
			User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!)
		]),
	NewsPost(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
			 id: "1",
			 comments: [
				Comment(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome comment", id: "1"),
				Comment(user: User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
				Comment(user: User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
				Comment(user: User(id: "4", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "awesome comment", id: "4"),
				Comment(user: User(id: "5", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
		], likes: [
			User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!)
		]),
	NewsPost(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
			 id: "1",
			 comments: [
				Comment(user: User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome comment", id: "1"),
				Comment(user: User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
				Comment(user: User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
				Comment(user: User(id: "4", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "awesome comment", id: "4"),
				Comment(user: User(id: "5", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
		], likes: [
			User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "2", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!),
			User(id: "3", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg")!)
		]),

]
