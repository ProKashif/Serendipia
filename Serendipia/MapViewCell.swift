//
//  MapViewCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/23/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import MapKit

class MapViewCell: UICollectionViewCell {
	@IBOutlet weak var mapView: MKMapView?
	
	func configure(houses: [House]) {
		let annotations = houses.map { HouseAnnotation(house: $0) }
		mapView?.addAnnotations(annotations)
		mapView?.showAnnotations(annotations, animated: false)
	}
}

private class HouseAnnotation: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D { return house.coordinates }
	var title: String? { return house.title }
	var house: House
	
	init(house: House) {
		self.house = house
		super.init()
	}
}
