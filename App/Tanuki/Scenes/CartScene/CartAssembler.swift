//
//  CartAssembler.swift
//  Tanuki
//
//  Created by Constantin on 03.07.2023.
//

import UIKit

final class CartAssembler {

	// MARK: - Internal Methods

	// Создаем сцену корзины.
	func assembly() -> UIViewController {
		let viewController = CartViewController()

		return viewController
	}
}
