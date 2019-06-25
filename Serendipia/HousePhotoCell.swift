//
//  HousePhotoCell.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/24/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class HousePhotoCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView?
	var photoUrl: URL?
	
//	required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//		
//	}
	
	override func prepareForReuse() {
		imageView?.image = UIImage(named: "house")
	}
}
