import Foundation
import UIKit
import AlamofireImage

//TODO: figure out why this won't work as an extension on UIView
@IBDesignable class DesignableView: UIView {
  
    // Rounded corner raius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    // Shadow color
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    // Shadow offsets
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    // Shadow opacity
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    // Shadow radius
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    // Border width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    // Border color
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    // Background color
    @IBInspectable var layerBackgroundColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.backgroundColor!)
        }
        set {
            self.backgroundColor = nil
            self.layer.backgroundColor = newValue.cgColor
        }
    }
  
    // Create bezier path of shadow for rasterize
    @IBInspectable var enableBezierPath: Bool {
        get {
            return self.layer.shadowPath != nil
        }
        set {
            if enableBezierPath {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            } else {
                self.layer.shadowPath = nil
            }
        }
    }
    
    // Mask to bounds controll
    @IBInspectable var maskToBounds: Bool {
        get{
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    // Rasterize option
    @IBInspectable var rasterize: Bool {
        get {
            return self.layer.shouldRasterize
        }
        set {
            self.layer.shouldRasterize = newValue
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}


@IBDesignable class DesignableButton: UIButton {
	// Rounded corner raius
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return self.layer.cornerRadius
		}
		set {
			self.layer.cornerRadius = newValue
		}
	}
}


extension UIViewController {
	@IBAction func dismiss() {
		dismiss(animated: true, completion: nil)
	}
	
}


extension UIView {
	var firstResponder: UIView? {
		guard !isFirstResponder else { return self }
		
		for subview in subviews {
			if let firstResponder = subview.firstResponder {
				return firstResponder
			}
		}
		
		return nil
	}
}


@IBDesignable class DesignableImageView: UIImageView {
	// Rounded corner raius
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return self.layer.cornerRadius
		}
		set {
			self.layer.cornerRadius = newValue
		}
	}
}

extension URL {
	var nsUrl: NSURL? { return NSURL(string: absoluteString) }
}


extension UIImage {
	var noir: UIImage? {
		let context = CIContext(options: nil)
		guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
		currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
		if let output = currentFilter.outputImage,
			let cgImage = context.createCGImage(output, from: output.extent) {
			return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
		}
		return nil
	}
}


@IBDesignable class DesignableTextView: UITextView {
	@IBInspectable var topInset: CGFloat = 0 {
		didSet {
			textContainerInset.top = topInset
		}
	}
	
	@IBInspectable var bottmInset: CGFloat = 0 {
		didSet {
			textContainerInset.bottom = bottmInset
		}
	}
	
	@IBInspectable var leftInset: CGFloat = 0 {
		didSet {
			textContainerInset.left = leftInset
		}
	}
	
	@IBInspectable var rightInset: CGFloat = 0 {
		didSet {
			textContainerInset.right = rightInset
		}
	}
}


extension UIColor {
	class var brownishGrey: UIColor {
		return UIColor(white: 117.0 / 255.0, alpha: 1.0)
	}
	
	class var appOrange: UIColor {
		return UIColor(red: 250.0 / 255.0, green: 145.0 / 255.0, blue: 23.0 / 255.0, alpha: 1.0)
	}
	
	class var darkishPink: UIColor {
		return UIColor(red: 237.0 / 255.0, green: 45.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
	}
}


typealias Closure = () -> ()


//extension UIImage {
//	static func radioButton(color: UIColor, radius: CGFloat, filled: Bool) -> UIImage? {
//		let view = DesignableView()
//		view.borderColor = color
//		view.borderWidth = 2
//		view.cornerRadius = radius
//		view.autoSetDimensions(to: CGSize(width: radius * 2, height: radius * 2))
//
//		if filled {
//			let fillView = DesignableView()
//			fillView.cornerRadius = radius
//			fillView.borderColor = color
//			fillView.borderWidth = radius/4
//			view.addSubview(fillView)
//			fillView.autoSetDimensions(to: CGSize(width: radius, height: radius))
//			fillView.autoCenterInSuperview()
//		}
//
//		return view.image
//	}
//
//}
//
//
//extension UIView {
//	var image: UIImage? {
//		UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
//		defer { UIGraphicsEndImageContext() }
//		if let context = UIGraphicsGetCurrentContext() {
//			layer.render(in: context)
//			let image = UIGraphicsGetImageFromCurrentImageContext()
//			return image
//		}
//		return nil
//	}
//}

extension UIImage {
	static var profileIcon: UIImage? { return self.init(named: "profileIcon") }
}


struct NoirFilter: CoreImageFilter {
	var filterName: String = "CIPhotoEffectNoir"
	var parameters: [String : Any] = [:]
}
