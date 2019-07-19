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
	
	@IBInspectable var startColor: UIColor = .clear
	
	@IBInspectable var endColor: UIColor = .clear
	
	@IBInspectable var startPoint: CGPoint = .zero
	
	@IBInspectable var endPoint: CGPoint = .zero
	
	override open class var layerClass: AnyClass {
		return CAGradientLayer.classForCoder()
	}
	
	func setup(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint) {
		let gradientLayer = layer as! CAGradientLayer
		gradientLayer.colors = colors
		gradientLayer.startPoint = startPoint
		gradientLayer.endPoint = endPoint
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		
		setup(colors: [startColor.cgColor, endColor.cgColor], startPoint: startPoint, endPoint: endPoint)
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
	
	@IBAction func pop() {
		navigationController?.popViewController(animated: true)
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
	@nonobjc class var brownishGrey: UIColor {
		return UIColor(white: 117.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var appOrange: UIColor {
		return UIColor(red: 250.0 / 255.0, green: 145.0 / 255.0, blue: 23.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var paypalBlue: UIColor {
		return UIColor(red: 68.0 / 255.0, green: 105.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var facebookBlue: UIColor {
		return UIColor(red: 68.0 / 255.0, green: 105.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
	}

	@nonobjc class var googleRed: UIColor {
		return UIColor(red: 241 / 255.0, green: 67 / 255.0, blue: 54 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var twitterBlue: UIColor {
		return UIColor(red: 3 / 255.0, green: 169 / 255.0, blue: 244 / 255.0, alpha: 1.0)
	}

	@nonobjc class var serendipiaPink: UIColor {
		return UIColor(red: 237 / 255.0, green: 45 / 255.0, blue: 141 / 255.0, alpha: 1.0)
	}

	@nonobjc class var dustyOrange: UIColor {
		return UIColor(red: 241.0 / 255.0, green: 122.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var azure: UIColor {
		return UIColor(red: 3.0 / 255.0, green: 169.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var darkishPink: UIColor {
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
	static var chevron: UIImage? { return self.init(named: "chevron") }
}


struct NoirFilter: CoreImageFilter {
	var filterName: String = "CIPhotoEffectNoir"
	var parameters: [String : Any] = [:]
}


extension UIView {
	func roundCorners(_ corners: CACornerMask, radii: CGFloat = 15) {
		layer.cornerRadius = radii
		layer.maskedCorners = corners
	}
}

extension UIView {
	var owningTableViewCell: UITableViewCell? {
		var superview = self.superview
		while superview?.isKind(of: UITableViewCell.self) == false {
			superview = superview?.superview
		}
		return superview as? UITableViewCell
	}
}


extension UILabel {
	var defaultFont: UIFont? {
		get { return self.font }
		set { self.font = newValue }
	}
}


public extension UIViewController
{
	func startAvoidingKeyboard()
	{
		NotificationCenter.default
			.addObserver(self,
						 selector: #selector(onKeyboardFrameWillChangeNotificationReceived(_:)),
						 name: UIResponder.keyboardWillChangeFrameNotification,
						 object: nil)
	}
	
	func stopAvoidingKeyboard()
	{
		NotificationCenter.default
			.removeObserver(self,
							name: UIResponder.keyboardWillChangeFrameNotification,
							object: nil)
	}
	
	@objc
	private func onKeyboardFrameWillChangeNotificationReceived(_ notification: Notification)
	{
		guard
			let userInfo = notification.userInfo,
			let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
			else {
				return
		}
		
		let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
		let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
		let intersection = safeAreaFrame.intersection(keyboardFrameInView)
		
		let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
		let animationDuration: TimeInterval = (keyboardAnimationDuration as? NSNumber)?.doubleValue ?? 0
		let animationCurveRawNSN = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
		let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
		let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
		
		UIView.animate(withDuration: animationDuration,
					   delay: 0,
					   options: animationCurve,
					   animations: {
						self.additionalSafeAreaInsets.bottom = intersection.height
						self.view.layoutIfNeeded()
		}, completion: nil)
	}
}

@IBDesignable
class DesignableTableView: UITableView {
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
