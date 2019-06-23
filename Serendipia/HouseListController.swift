//
//  HouseListController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import CoreLocation

class HouseListController: UIViewController {
	@IBOutlet private var collectionView: UICollectionView?
	private var dataSource: UICollectionViewDataSource = ListHouseDataSource() {
		didSet {
			collectionView?.dataSource = dataSource
			if let delegate = dataSource as? UICollectionViewDelegate {
				collectionView?.delegate = delegate
			}
		}
	}
	
	@IBAction func changeSearchTapped() {
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func changeViewTapped(sender: UIButton) {
		if dataSource.isKind(of: ListHouseDataSource.self) {
			dataSource = MapHouseDataSource()
			sender.setTitle("List View", for: .normal)
		} else if dataSource.isKind(of: MapHouseDataSource.self) {
			dataSource = ListHouseDataSource()
			sender.setTitle("Map View", for: .normal)
		}
		
		collectionView?.dataSource = dataSource
		collectionView?.reloadData()
	}
	
	@IBAction func filtersTapped() {
		
	}
	
	private func bookHouse(houseId: String) {
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dataSource = ListHouseDataSource()
	}
}



private class ListHouseDataSource: NSObject, UICollectionViewDataSource {
	var houses: [House] = testHouses
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return houses.count
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "house", for: indexPath)
		if let cell = cell as? HouseListCell {
			cell.configure(house: houses[indexPath.row])
			cell.houseSelected = bookHouse
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
	}

	private func bookHouse(houseId: String) {
		
	}
}


private class MapHouseDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	var houses: [House] = testHouses
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "map", for: indexPath)
		if let cell = cell as? MapViewCell {
			cell.configure(houses: houses)
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			let height = collectionView.frame.height - layout.headerReferenceSize.height
			return CGSize(width: collectionView.frame.width, height: height)
		}
		return .zero
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
	}
}


let testHouses: [House] = [
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Maison_Bow%C3%A9.jpg/1920px-Maison_Bow%C3%A9.jpg")!],
		  address: Address(city: "San Francisco", houseNumber: "123", street: "Haight St"), rooms: [
			Room(rates: [Room.Rate(date: Date(), price: 50)], roomNumber: 1)
		], id: "1", title: "Serendipia Cooperative", coordinates: CLLocationCoordinate2D(latitude: 37.4002029, longitude: -122.4110734)),
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/9/9b/Dumbrava_Rosie_11.jpg")!],
		  address: Address(city: "Los Gatos", houseNumber: "233", street: "Booger St"), rooms: [
			Room(rates: [Room.Rate(date: Date(), price: 40)], roomNumber: 2)
		], id: "2", title: "JLO's Mom's House", coordinates: CLLocationCoordinate2D(latitude: 37.829, longitude: -122.4311074)),
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/%22%D0%A3%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%92.%D0%9F._%D0%A1%D1%83%D0%BA%D0%B0%D1%87%D0%B5%D0%B2%D0%B0%22%2C_%D1%84%D0%B0%D1%81%D0%B0%D0%B4_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F_%D0%9A%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B3%D0%B0%D0%BB%D0%B5%D1%80%D0%B5%D0%B8.jpg/1920px-%22%D0%A3%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%92.%D0%9F._%D0%A1%D1%83%D0%BA%D0%B0%D1%87%D0%B5%D0%B2%D0%B0%22%2C_%D1%84%D0%B0%D1%81%D0%B0%D0%B4_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F_%D0%9A%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B3%D0%B0%D0%BB%D0%B5%D1%80%D0%B5%D0%B8.jpg")!],
		  address: Address(city: "Alameda", houseNumber: "284", street: "Ajar Ave"), rooms: [
			Room(rates: [Room.Rate(date: Date(), price: 50)], roomNumber: 1)
		], id: "3", title: "Serendipia Nest", coordinates: CLLocationCoordinate2D(latitude: 37.800, longitude: -122.473)),
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Makedonska_street%2C_Belgrade%2C_Serbia%2C_2019._09.jpg/1920px-Makedonska_street%2C_Belgrade%2C_Serbia%2C_2019._09.jpg")!],
		  address: Address(city: "San Francisco", houseNumber: "1243", street: "Left St"), rooms: [
			Room(rates: [Room.Rate(date: Date(), price: 20)], roomNumber: 3)
		], id: "4", title: "Burger King", coordinates: CLLocationCoordinate2D(latitude: 37.80029, longitude: -122.10334))
]



