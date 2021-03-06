//
//  HouseListCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/22/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit
import PureLayout
import AlamofireImage

class HouseListCell: UICollectionViewCell {
	@IBOutlet private weak var previewImage: UIImageView!
	@IBOutlet private weak var cityLabel: UILabel!
	@IBOutlet private weak var streetLabel: UILabel!
	@IBOutlet private weak var bookButton: UIButton!
	
	private var houseId: String?
	private(set) var enabled = true {
		didSet {
			if enabled {
				bookButton.backgroundColor = .darkishPink
				streetLabel.textColor = .darkishPink
				removePropertyUnavailableView()
			} else {
				bookButton.backgroundColor = .lightGray
				streetLabel.textColor = .lightGray
				addPropertyUnavailableView()
			}
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		previewImage.af_cancelImageRequest()
		previewImage.image = UIImage(named: "house")
		cityLabel.text = "Loading..."
		streetLabel.text = "Loading..."
	}
	
	func configure(house: House, enabled: Bool = true) {
		houseId = house.id
		
		guard let imageUrl = house.photoUrls.first else {
			//error
			return
		}
		
		previewImage.af_setImage(withURL: imageUrl, placeholderImage: UIImage(named: "house"), filter: enabled ? nil : NoirFilter())
		cityLabel.text = house.address.city
		streetLabel.text = house.address.houseNumber + " " + house.address.street
		
		self.enabled = enabled
	}
	
	private func addPropertyUnavailableView() {
		if propertyUnavailableView.superview == nil {
			previewImage.addSubview(propertyUnavailableView)
			propertyUnavailableView.autoCenterInSuperviewMargins()
		}
	}
	
	private func removePropertyUnavailableView() {
		propertyUnavailableView.removeFromSuperview()
	}
	
	private lazy var propertyUnavailableView: UIView = {
		let label1 = UILabel()
		label1.text = "Property not available for your dates"
		label1.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		label1.textAlignment = .center
		
		let label2 = UILabel()
		label2.text = "Change your dates"
		label2.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label2.textColor = .darkishPink
		label2.textAlignment = .center
		
		let view = UIView()
		view.addSubview(label1)
		view.addSubview(label2)
		view.layer.cornerRadius = 10
		view.backgroundColor = .white
		view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		
		label1.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)
		label2.autoPinEdges(toSuperviewMarginsExcludingEdge: .top)
		label2.autoPinEdge(.top, to: .bottom, of: label1, withOffset: 4)
		
		return view
	}()
}


