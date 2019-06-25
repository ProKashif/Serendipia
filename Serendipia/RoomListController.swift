//
//  RoomListController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/25/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class RoomListController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView!
	private(set) var collectionViewDataSource = RoomListDataSource()
	
	override func viewDidLoad() {
		collectionViewDataSource = RoomListDataSource()
		collectionViewDataSource.rooms = testRooms
		collectionView.dataSource = collectionViewDataSource
		if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.itemSize.width = collectionView.frame.width - 20
		}
	}
}


class RoomListDataSource: NSObject, UICollectionViewDataSource {
	var rooms: [Room]?

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return rooms?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "room", for: indexPath)
		if let cell = cell as? RoomListCell, let room = rooms?[indexPath.row] {
			cell.configure(room: room)
		}
		return cell
	}
}


