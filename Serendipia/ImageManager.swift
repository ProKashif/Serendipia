//
//  ImageManager.swift
//  Serendipia
//
//  Created by Marty Ulrich on 6/30/19.
//  Copyright © 2019 Marty Ulrich. All rights reserved.
//

import UIKit

typealias ImageFetchCompletion = (UIImage, URL) -> ()

class ImageManager {
	private let cache = ImageCache.shared
	static let shared = ImageManager()
	
	func fetchImage(for url: URL, completion: @escaping ImageFetchCompletion) {
		if let image = cache.image(for: url) {
			completion(image, url)
		} else {
			DispatchQueue.global(qos: .userInitiated).async { [weak self] in
				if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
					self?.cache.cacheImage(image, for: url)
					DispatchQueue.main.async {
						completion(image, url)
					}
				}
			}
		}
	}
}
