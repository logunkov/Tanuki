//
//  Dish.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

import UIKit

// Структура блюда.
struct Dish: Codable {

	// MARK: - Internal properties

	let url: URL
	let name: String
	let description: String
	let tag: [String]
	let price: Int
	let weight: Int
	var quantity: Int
	var isFavorite: Bool

	enum CodingKeys: String, CodingKey {
		case url
		case name
		case description
		case tag
		case price
		case weight
		case quantity
		case isFavorite
	}

	// MARK: - Lifecycle

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		url = try container.decode(URL.self, forKey: .url)
		name = try container.decode(String.self, forKey: .name)
		description = try container.decode(String.self, forKey: .description)
		tag = try container.decode([String].self, forKey: .tag)
		price = try container.decode(Int.self, forKey: .price)
		weight = try container.decode(Int.self, forKey: .weight)

		self.quantity = 1
		self.isFavorite = false
	}

	// MARK: - Internal methods

	func getImage() -> UIImage? {
		ImageCache.shared.loadImageCache(from: url)
	}

	func loadImage() {
		ImageCache.shared.loadImage(from: url)
	}
}
