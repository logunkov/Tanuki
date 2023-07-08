//
//  CategoryPresenter.swift
//  Tanuki
//
//  Created by Constantin on 04.07.2023.
//

import UIKit

protocol ICategoryPresenter {
	func navigateToNextScene(dish: Dish)
}

final class CategoryPresenter: ICategoryPresenter {

	// MARK: - Internal Properties

	weak var view: CategoryViewController?

	// MARK: - Life Cycle

	init(view: CategoryViewController) {
		self.view = view
	}

	// MARK: - Internal Methods

	// Создаем сцену с блюдом.
	func navigateToNextScene(dish: Dish) {
		let dishViewController = DishViewController(dish)
		dishViewController.modalPresentationStyle = .overFullScreen
		view?.present(dishViewController, animated: true, completion: nil)
	}
}
