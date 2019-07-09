//
//  HouseListController.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import CoreLocation

class HouseListController: UIViewController, ReservationBuilding {
	var reservation: Reservation?
	var houses = testHouses
	@IBOutlet private var collectionView: UICollectionView?
	@IBOutlet weak var locationAndDateLabel: UILabel!
	private var dataSource: UICollectionViewDataSource = ListHouseDataSource() {
		didSet {
			collectionView?.dataSource = dataSource
			if let delegate = dataSource as? UICollectionViewDelegate {
				collectionView?.delegate = delegate
			}
			
			if let houseDataSource = dataSource as? HouseDataSource {
				houseDataSource.houses = houses
			}
		}
	}
	var city: String?
	var searchDates: String?
	
	@IBAction func changeSearchTapped() {
		popToSearch()
	}
	
	private func popToSearch() {
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dataSource = ListHouseDataSource()
		if let city = city, let searchDates = searchDates {
			locationAndDateLabel.text = "\(city), \(searchDates)"
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		if var reservationBuilder = segue.destination as? ReservationBuilding, let cell = sender as? UICollectionViewCell {
			reservation?.house = houses[collectionView?.indexPath(for: cell)?.row ?? 0]
			reservationBuilder.reservation = reservation
		}
		
		if let filterController = segue.destination as? FilterController {
			filterController.filtersSelected = { selectedFilters in
				//TODO: handle filters
			}
		}
	}
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if let cell = sender as? HouseListCell, cell.enabled == false {
			popToSearch()
			return false
		}
		
		return true
	}
}

protocol HouseDataSource: UICollectionViewDataSource {
	var houses: [House] { get set }
}

private class ListHouseDataSource: NSObject, HouseDataSource {
	var houses: [House] = []
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return houses.count
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "house", for: indexPath)
		if let cell = cell as? HouseListCell {
			cell.configure(house: houses[indexPath.row], enabled: true)
		}
		return cell
	}
}


private class MapHouseDataSource: NSObject, HouseDataSource, UICollectionViewDelegateFlowLayout {
	var houses: [House] = []
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
}


let testHouses: [House] = [
	House(photoUrls: [
		URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Maison_Bow%C3%A9.jpg/1920px-Maison_Bow%C3%A9.jpg")!,
		URL(string: "https://upload.wikimedia.org/wikipedia/commons/9/9b/Dumbrava_Rosie_11.jpg")!,
		URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/%22%D0%A3%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%92.%D0%9F._%D0%A1%D1%83%D0%BA%D0%B0%D1%87%D0%B5%D0%B2%D0%B0%22%2C_%D1%84%D0%B0%D1%81%D0%B0%D0%B4_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F_%D0%9A%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B3%D0%B0%D0%BB%D0%B5%D1%80%D0%B5%D0%B8.jpg/1920px-%22%D0%A3%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%92.%D0%9F._%D0%A1%D1%83%D0%BA%D0%B0%D1%87%D0%B5%D0%B2%D0%B0%22%2C_%D1%84%D0%B0%D1%81%D0%B0%D0%B4_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F_%D0%9A%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B3%D0%B0%D0%BB%D0%B5%D1%80%D0%B5%D0%B8.jpg")!,
		URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Makedonska_street%2C_Belgrade%2C_Serbia%2C_2019._09.jpg/1920px-Makedonska_street%2C_Belgrade%2C_Serbia%2C_2019._09.jpg")!,
		],
		  address: Address(city: "San Francisco", houseNumber: "123", street: "Haight St"),
		  id: "1",
		  title: "Serendipia Cooperative",
		  coordinates: CLLocationCoordinate2D(latitude: 37.4002029, longitude: -122.4110734),
		  amenities: [.wifi, .cleaning],
		  description: "Looking for that urban oasis tucked away inside bustling North Beach? Look no further. This vintage, free-standing home will be the envy of all your friends. Enter through your own private passage away into a secret garden: You'll never believe this is your home, steps away from Washington Park, Columbus Avenue and all that Little Italy has to offer.", manager: TestUsers.randomUser()),
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/9/9b/Dumbrava_Rosie_11.jpg")!],
		  address: Address(city: "Los Gatos", houseNumber: "233", street: "Booger St"),
		  id: "2",
		  title: "JLO's House",
		  coordinates: CLLocationCoordinate2D(latitude: 37.829, longitude: -122.4311074),
		  amenities: [.cleaning, .snacks],
		  description: "Boogy Boody Looking for that urban oasis tucked away inside bustling North Beach? Look no further. This vintage, free-standing home will be the envy of all your friends. Enter through your own private passage away into a secret garden: You'll never believe this is your home, steps away from Washington Park, Columbus Avenue and all that Little Italy has to offer.", manager: TestUsers.randomUser()),
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/%22%D0%A3%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%92.%D0%9F._%D0%A1%D1%83%D0%BA%D0%B0%D1%87%D0%B5%D0%B2%D0%B0%22%2C_%D1%84%D0%B0%D1%81%D0%B0%D0%B4_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F_%D0%9A%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B3%D0%B0%D0%BB%D0%B5%D1%80%D0%B5%D0%B8.jpg/1920px-%22%D0%A3%D1%81%D0%B0%D0%B4%D1%8C%D0%B1%D0%B0_%D0%92.%D0%9F._%D0%A1%D1%83%D0%BA%D0%B0%D1%87%D0%B5%D0%B2%D0%B0%22%2C_%D1%84%D0%B0%D1%81%D0%B0%D0%B4_%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D1%8F_%D0%9A%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B3%D0%B0%D0%BB%D0%B5%D1%80%D0%B5%D0%B8.jpg")!],
		  address: Address(city: "Alameda", houseNumber: "284", street: "Ajar Ave"),
		  id: "3",
		  title: "Serendipia Nest",
		  coordinates: CLLocationCoordinate2D(latitude: 37.800, longitude: -122.473),
		  amenities: [.cleaning, .snacks, .wifi],
		  description: "Looking for that urban oasis tucked away inside bustling North Beach? Look no further. This vintage, free-standing home will be the envy of all your friends. Enter through your own private passage away into a secret garden: You'll never believe this is your home, steps away from Washington Park, Columbus Avenue and all that Little Italy has to offer.", manager: TestUsers.randomUser()),
	House(photoUrls: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Makedonska_street%2C_Belgrade%2C_Serbia%2C_2019._09.jpg/1920px-Makedonska_street%2C_Belgrade%2C_Serbia%2C_2019._09.jpg")!],
		  address: Address(city: "San Francisco", houseNumber: "1243", street: "Left St"),
		  id: "4",
		  title: "Burger King",
		  coordinates: CLLocationCoordinate2D(latitude: 37.80029, longitude: -122.10334),
		  amenities: [.cleaning, .snacks, .wifi, .cleaning, .snacks, .wifi, .cleaning, .snacks, .wifi, .cleaning, .snacks, .wifi, .cleaning, .snacks, .wifi, .cleaning, .snacks, .wifi, .laundry],
		  description: "Looking for that urban oasis tucked away inside bustling North Beach? Look no further. This vintage, free-standing home will be the envy of all your friends. Enter through your own private passage away into a secret garden: You'll never believe this is your home, steps away from Washington Park, Columbus Avenue and all that Little Italy has to offer.", manager: TestUsers.randomUser())
]


let testRooms = [
	Room(photoUrls: [
		URL(string: "https://secure.img1-fg.wfcdn.com/im/74202513/resize-h800-w800%5Ecompr-r85/4555/45554584/Valencia+5+Piece+Bedroom+Set.jpg")!,
		URL(string: "https://s7d4.scene7.com/is/image/roomandboard/wyatt_438274_19e_g?hei=725&$str_g$")!,
		URL(string: "https://s3.amazonaws.com/furniture.retailcatalog.us/products/201732/large/1700-dark-oak.jpg")!
		], rates: [Room.Rate(date: Date(), price: 50)],
		   roomNumber: 1,
		   name: "Freedom Room"),
	Room(photoUrls: [
		URL(string: "https://s3.amazonaws.com/furniture.retailcatalog.us/products/201732/large/1700-dark-oak.jpg")!,
		URL(string: "https://s7d4.scene7.com/is/image/roomandboard/wyatt_438274_19e_g?hei=725&$str_g$")!,
		URL(string: "https://secure.img1-fg.wfcdn.com/im/74202513/resize-h800-w800%5Ecompr-r85/4555/45554584/Valencia+5+Piece+Bedroom+Set.jpg")!,
		], rates: [Room.Rate(date: Date(), price: 40)],
		   roomNumber: 2,
		   name: "Study Room"),
	Room(photoUrls: [
		URL(string: "https://s7d4.scene7.com/is/image/roomandboard/wyatt_438274_19e_g?hei=725&$str_g$")!,
		URL(string: "https://secure.img1-fg.wfcdn.com/im/74202513/resize-h800-w800%5Ecompr-r85/4555/45554584/Valencia+5+Piece+Bedroom+Set.jpg")!,
		URL(string: "https://s3.amazonaws.com/furniture.retailcatalog.us/products/201732/large/1700-dark-oak.jpg")!
		], rates: [Room.Rate(date: Date(), price: 55)],
		   roomNumber: 3,
		   name: "Cheese Room"),
	Room(photoUrls: [
		URL(string: "https://s7d4.scene7.com/is/image/roomandboard/wyatt_438274_19e_g?hei=725&$str_g$")!,
		URL(string: "https://secure.img1-fg.wfcdn.com/im/74202513/resize-h800-w800%5Ecompr-r85/4555/45554584/Valencia+5+Piece+Bedroom+Set.jpg")!,
		URL(string: "https://s3.amazonaws.com/furniture.retailcatalog.us/products/201732/large/1700-dark-oak.jpg")!
		], rates: [Room.Rate(date: Date(), price: 44.49)],
		   roomNumber: 4,
		   name: "People Room")
]
