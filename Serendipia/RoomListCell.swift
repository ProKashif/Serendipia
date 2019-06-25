//
//  RoomListCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/25/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class RoomListCell: UICollectionViewCell {
	@IBOutlet weak var roomNameLabel: UILabel!
	@IBOutlet weak var rateLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	private var imageUrl: URL?
	
	func configure(room: Room) {
		roomNameLabel.text = room.name
		let cheapestRate = room.rates.reduce(Float.greatestFiniteMagnitude, { result, rate -> Float in
			return rate.price < result ? rate.price : result
		})
		rateLabel.text = "$\(String(format: "%.2f", cheapestRate))/night"
		imageUrl = room.photoUrls.first
		if let imageUrl = imageUrl {
			DispatchQueue.global(qos: .userInitiated).async { [weak self] in
				if let imageData = try? Data(contentsOf: imageUrl) {
					if imageUrl == self?.imageUrl {
						DispatchQueue.main.async {
							self?.imageView.image = UIImage(data: imageData)
						}
					}
				}
			}
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = UIImage(named: "house")
	}
}
