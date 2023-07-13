//
//  ImageCache.swift
//  Tanuki
//
//  Created by Constantin on 13.07.2023.
//

import UIKit

final class ImageCache {

	// MARK: - Internal properties

	static let shared = ImageCache()

	// MARK: - Private properties

	private let imageCache = NSCache<NSString, UIImage>()
	private var image: UIImage?

	// MARK: - Internal methods

	// Загружаем картинку из кеша.
	func loadImageCache(from url: URL) -> UIImage? {
		imageCache.object(forKey: url.absoluteString as NSString)
	}

	// Загружаем картинку в кеш.
	func loadImage(from url: URL) {
		let session = URLSession.shared

		session.dataTask(with: url) { data, _, _ in
			if let data = data, let image = UIImage(data: data) {
				DispatchQueue.main.async {
					self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
				}
			}
		}
		.resume()
	}
}
