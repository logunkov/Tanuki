//
//  CategoryAssembler.swift
//  Tanuki
//
//  Created by Constantin on 04.07.2023.
//

import UIKit

final class CategoryAssembler {

	let title: String

	init(title: String) {
		self.title = title
	}

	// MARK: - Internal Methods

	// Создаем сцену с категориями блюд.
	func assembly() -> UIViewController {
		let viewController = CategoryViewController(titleText: title)

		return viewController
	}
}
