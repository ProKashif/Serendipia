//
//  NewsPostConfiguring.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

protocol NewsPostConfiguring {
	func configure(newsPost: NewsPost)
}


class NewsCell: UITableViewCell {	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		selectionStyle = .none
	}
}
