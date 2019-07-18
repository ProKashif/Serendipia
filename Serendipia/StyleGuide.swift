//
//  StyleGuide.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/16/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

@objc
enum FontStyle: Int {
	case none = -1
	case body
	case title
	case header
	case subtitle
}

extension UIFont {
	convenience init?(fontStyle: FontStyle?) {
		let fontStyle = fontStyle ?? .none
		var circularFontName: String { return "CircularStd-Book" }

		switch fontStyle {
		case .body:
			self.init(name: circularFontName, size: 17)
		case .header:
			self.init(name: circularFontName, size: 24)
		case .title:
			self.init(name: circularFontName, size: 40)
		case .subtitle:
			self.init(name: circularFontName, size: 17)
		case .none:
			self.init(name: circularFontName, size: UIFont.systemFontSize)
		}
		
	}
}

@IBDesignable
class Label: UILabel {
	@IBInspectable var fontStyle: Int = 0 {
		didSet {
			guard let fontStyle = FontStyle(rawValue: self.fontStyle) else { return }
			var textColor: UIColor
			font = UIFont(fontStyle: fontStyle)
			switch fontStyle {
			default:
				textColor = .darkGray
			}
			self.textColor = textColor
		}
	}
	
	
}
