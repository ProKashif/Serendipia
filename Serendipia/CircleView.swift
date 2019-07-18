//
//  CircleView.swift
//  Serendipia
//
//  Created by Marty Ulrich on 7/16/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
	
	var circleLayer: CAShapeLayer!
	var backgroundLayer: CAShapeLayer!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .clear
		
		let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat(.pi * -0.5), endAngle: CGFloat(.pi * 1.5), clockwise: true)
		
		backgroundLayer = CAShapeLayer()
		backgroundLayer.path = circlePath.cgPath
		backgroundLayer.fillColor = UIColor.clear.cgColor
		backgroundLayer.strokeColor = UIColor.lightGray.cgColor
		backgroundLayer.lineWidth = 5.0
		backgroundLayer.strokeEnd = 1.0
		layer.addSublayer(backgroundLayer)
		
		circleLayer = CAShapeLayer()
		circleLayer.path = circlePath.cgPath
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.strokeColor = UIColor.orange.cgColor
		circleLayer.lineWidth = 5.0
		circleLayer.strokeEnd = 0.0
		layer.addSublayer(circleLayer)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
