//
//  HouseDetailsController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/24/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class HouseDetailsController: UIViewController {
	var house: House?
	
	var housePhotosDataSource = HousePhotoScrollerDataSource()
	@IBOutlet weak var housePhotoScroller: UICollectionView?
	
	var houseAmenitiesDataSource = HouseAmenitiesDataSource()
	@IBOutlet weak var houseAmenitiesScroller: UICollectionView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		housePhotosDataSource.house = house
		housePhotoScroller?.dataSource = housePhotosDataSource
		if let flowLayout = housePhotoScroller?.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.itemSize.width = view.frame.width
		}
		
		houseAmenitiesDataSource.house = house
		houseAmenitiesScroller?.dataSource = houseAmenitiesDataSource
	}
}


class HousePhotoScrollerDataSource: NSObject, UICollectionViewDataSource {
	var house: House?
	var imageCache = NSCache<NSURL, UIImage>()
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return house?.photoUrls.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "house", for: indexPath)
		if let cell = cell as? HousePhotoCell, let photoUrl = house?.photoUrls[indexPath.row] {
			cell.photoUrl = photoUrl
			if let image = imageCache.object(forKey: photoUrl.nsUrl!) {
				cell.imageView?.image = image
			} else {
				DispatchQueue.global(qos: .userInitiated).async { [weak self] in
					guard
						let imageData = try? Data(contentsOf: photoUrl),
						let image = UIImage(data: imageData)
					else { return }
					
					self?.imageCache.setObject(image, forKey: photoUrl.nsUrl!)
					
					if photoUrl == cell.photoUrl {
						DispatchQueue.main.async {
							cell.imageView?.image = image
						}
					}
				}
			}
		}
		return cell
	}
	
	
}


class HouseAmenitiesDataSource: NSObject, UICollectionViewDataSource {
	var house: House?
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return house?.amenities.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "amenity", for: indexPath)
		if let cell = cell as? HouseAmenityCell {
			
			cell.imageView?.image = house?.amenities[indexPath.row].icon
		}
		return cell
	}}
