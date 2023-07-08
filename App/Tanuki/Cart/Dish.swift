//
//  Dish.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

import UIKit

// Структура блюда.
struct Dish {
	var image: UIImage
	var name: String
	var description: String
	var tag: [String]
	var price: Int
	var weight: Int
	var quantity = 1
	var isFavorite = false
}
