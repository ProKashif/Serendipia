//
//  HouseListCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class HouseListCell: UICollectionViewCell {
	@IBOutlet private weak var previewImage: UIImageView!
	@IBOutlet private weak var cityLabel: UILabel!
	@IBOutlet private weak var streetLabel: UILabel!
	private var houseId: String?
	
	var houseSelected: ((String) -> ())?
	
//	@IBAction func bookTapped() {
//		guard
//			let houseId = houseId,
//			let houseSelected = houseSelected
//		else {
//			fatalError()
//		}
//		houseSelected(houseId)
//	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		houseSelected = nil
		previewImage.image = UIImage(named: "house")
		cityLabel.text = "xxx"
		streetLabel.text = "xxx"
	}
	
	func configure(house: House) {
		houseId = house.id
		DispatchQueue.global(qos: .userInteractive).async { [weak self] in
			if let imageData = try? Data(contentsOf: house.photoUrls[0]) {
				if house.id == self?.houseId {
					DispatchQueue.main.async {
						self?.previewImage.image = UIImage(data: imageData)
					}
				}
			}
		}
		
		cityLabel.text = house.address.city
		streetLabel.text = house.address.houseNumber + " " + house.address.street
	}
	
}
