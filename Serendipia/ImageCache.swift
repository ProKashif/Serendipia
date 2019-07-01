//
//  ImageCache.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/26/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

class ImageCache {
	static let shared = ImageCache()
	private let cache = NSCache<NSURL, UIImage>()
	
	func image(for url: URL) -> UIImage? {
		return cache.object(forKey: url.nsUrl!)
	}
	
	func cacheImage(_ image: UIImage, for url: URL) {
		cache.setObject(image, forKey: url.nsUrl!)
	}
}
