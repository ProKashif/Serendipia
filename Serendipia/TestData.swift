//
//  TestData.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/3/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class TestUsers {
	static func jLo() -> User {
		return User(id: "1", name: "Jean Liock Michaux", email: "jlomichaux@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://user-images.strikinglycdn.com/res/hrscywv4p/image/upload/c_limit,fl_lossy,h_1440,w_720,f_auto,q_auto/75600/IMG_6305_s06qsz.jpg")!)
	}
	
	static func yansou() -> User {
		return User(id: "2", name: "Yansou Girard", email: "yansou@gmail.com", phoneNumber: "415-555-5555", profilePhotoUrl: URL(string: "https://miro.medium.com/max/3150/1*tveD7-aBURAc8Z4Js6gPow.jpeg")!)
	}
	
	static func anna() -> User {
		return User(id: "3", name: "Anna Lepinski", email: "anna@anna.com", phoneNumber: "444-333-2038", profilePhotoUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMTM4MTY3NTQyMF5BMl5BanBnXkFtZTYwMTk2MzQ2._V1_UX214_CR0,0,214,317_AL_.jpg")!)
	}
	
	static func randomUser() -> User {
		switch Int.random(in: 0...2) {
		case 0:
			return jLo()
		case 1:
			return yansou()
		case 2:
			return anna()
		default:
			return jLo()
		}
	}
}



class TestPosts {
	let testPosts = [
		NewsPost(user: TestUsers.randomUser(),
		body: "Last night I went down to the watering hole to think about entrepreneural stuff.",
		id: "1",
		comments: [
		Comment(user: TestUsers.randomUser(), body: "This is an awesome comment", id: "1"),
		Comment(user: TestUsers.randomUser(), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
		Comment(user: TestUsers.randomUser(), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
		Comment(user: TestUsers.randomUser(), body: "awesome comment", id: "4"),
		Comment(user: TestUsers.randomUser(), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
		], likes: [
		TestUsers.randomUser()
		]),
		NewsPost(user: TestUsers.randomUser(),
				 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
				 id: "1",
				 comments: [
					Comment(user: TestUsers.randomUser(), body: "This is an awesome comment", id: "1"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
					Comment(user: TestUsers.randomUser(), body: "awesome comment", id: "4"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
			], likes: [
				TestUsers.randomUser(),
				TestUsers.randomUser(),
				TestUsers.randomUser()
			]),
		NewsPost(user: TestUsers.randomUser(),
				 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
				 id: "1",
				 comments: [
					Comment(user: TestUsers.randomUser(), body: "This is an awesome comment", id: "1"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
			], likes: [
				TestUsers.randomUser(),
				TestUsers.randomUser(),
				TestUsers.randomUser()
			]),
		NewsPost(user: TestUsers.randomUser(),
				 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
				 id: "1",
				 comments: [
					Comment(user: TestUsers.randomUser(), body: "This is an awesome comment", id: "1"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
			], likes: [
				TestUsers.randomUser(),
				TestUsers.randomUser(),
				TestUsers.randomUser()
			]),
		NewsPost(user: TestUsers.randomUser(),
				 body: "asldfkj as;ldfjl ;asdfjals ;dkjf;lajs df;ljasd f;ljasfkl ;jas;ldkfj ;lasdfj l asfl;jk dfkl;j dsf;ljksadl;f kjas;lkfjaslkdfj",
				 id: "1",
				 comments: [
					Comment(user: TestUsers.randomUser(), body: "This is an awesome comment", id: "1"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome asdfj ;ldkfj a;lsf post", id: "2"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesome alskdjf a;slkdjf;lasjfl;kajs d;flkjasdl ;kfj;lsakhg ;lag;lasgjpost", id: "3"),
					Comment(user: TestUsers.randomUser(), body: "awesome comment", id: "4"),
					Comment(user: TestUsers.randomUser(), body: "This is an awesomeasjfl;asjk df;laksjf ;lajksdf ;ljasl;kf jas;dlkfj a;lsdjkf;lasjdf;laksjdf l;aksjfl;kjsf comment", id: "5")
			], likes: [
				TestUsers.randomUser(),
				TestUsers.randomUser()
			])
		]
}


class TestFilters {
	let testFilters = [
		Filter(name: "Washer/Dryer", selected: true),
		Filter(name: "WiFi", selected: true),
		Filter(name: "Parking", selected: false),
		Filter(name: "Pool", selected: false),
		Filter(name: "Terrace", selected: false),
		Filter(name: "Private Rooms", selected: false),
		Filter(name: "Cleaning Services", selected: false),
		Filter(name: "24 Hours Front Desk", selected: false),
		Filter(name: "Breakfast Included", selected: false),
		Filter(name: "Other", selected: false)
	]
}


class TestPayments {
	let testPayments = [
		Payment(type: .paypal, title: "PayPal", color: .paypalBlue),
		Payment(type: .creditCard, title: "Credit Card", color: .darkishPink),
	]
}


class TestLogins {
	let testLoginOptions = [
		LoginOption(backgroundColor: .facebookBlue, option: .facebook, icon: UIImage(named: "facebookLoginIcon")),
		LoginOption(backgroundColor: .googleRed, option: .google, icon: UIImage(named: "googleLoginIcon")),
		LoginOption(backgroundColor: .twitterBlue, option: .twitter, icon: UIImage(named: "twitterLoginIcon")),
		LoginOption(backgroundColor: .serendipiaPink, option: .serendipia, icon: UIImage(named: "serendipiaLoginIcon"))
	]
}
