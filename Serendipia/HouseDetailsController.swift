//
//  HouseDetailsController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/24/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class HouseDetailsController: UIViewController, ReservationBuilding {
	var reservation: Reservation?
	var house: House? { return reservation?.house}
	
	var housePhotosDataSource = HousePhotoScrollerDataSource()
	@IBOutlet weak var housePhotoScroller: UICollectionView?
	
	var houseAmenitiesDataSource = HouseAmenitiesDataSource()
	@IBOutlet weak var houseAmenitiesScroller: UICollectionView?
	
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var houseManagerLabel: UILabel!
	@IBOutlet weak var phoneNumberLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var pageControl: UIPageControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		housePhotosDataSource.house = house
		housePhotoScroller?.delegate = housePhotosDataSource
		housePhotoScroller?.dataSource = housePhotosDataSource
		housePhotosDataSource.pageControl = pageControl
		if let flowLayout = housePhotoScroller?.collectionViewLayout as? UICollectionViewFlowLayout {
			flowLayout.itemSize.width = view.frame.width
		}
		
		houseAmenitiesDataSource.house = house
		houseAmenitiesScroller?.dataSource = houseAmenitiesDataSource
		
		cityLabel.text = house?.address.city
		addressLabel.text = house?.address.streetAndHouseNumber
		descriptionLabel.text = house?.description
		houseManagerLabel.text = house?.manager.name
		phoneNumberLabel.text = house?.manager.phoneNumber
		emailLabel.text = house?.manager.email
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let roomListController = segue.destination as? RoomListController {
			roomListController.collectionViewDataSource.rooms = testRooms
			
			if var reservationBuilder = segue.destination as? ReservationBuilding {
				reservationBuilder.reservation = reservation
			}
		}
	}
}


class HousePhotoScrollerDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
	var house: House?
	var imageCache = NSCache<NSURL, UIImage>()
	var pageControl: UIPageControl?
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
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		pageControl?.currentPage = indexPath.item
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		guard let collectionView = scrollView as? UICollectionView else { return }

		pageControl?.currentPage = collectionView.indexPathsForVisibleItems.first?.item ?? 0
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
	}
}
