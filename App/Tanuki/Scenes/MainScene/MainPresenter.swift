//
//  MainPresenter.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

import UIKit

protocol IMainPresenter {
	func navigateToNextScene(title: String)
}

final class MainPresenter: IMainPresenter {

	// MARK: - Internal Properties

	weak var view: MainViewController?

	// MARK: - Life Cycle

	init(view: MainViewController) {
		self.view = view
	}

	// MARK: - Internal Methods

	// Создаем сцену с категориями блюд.
	func navigateToNextScene(title: String) {
		let categoryViewController = CategoryAssembler(title: title).assembly()
		view?.navigateTo(scene: categoryViewController)
	}
}
