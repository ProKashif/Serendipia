//
//  DividerLine.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/24/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import PureLayout

class DividerLine: UIView {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		autoSetDimension(.height, toSize: 1)
		backgroundColor = .lightGray
		alpha = 0.75
	}
}
