//
//  Cart.swift
//  Tanuki
//
//  Created by Constantin on 07.07.2023.
//

import Foundation

// Корзина для блюд.
final class Cart {

	// MARK: - Singleton

	static let shared = Cart()

	// MARK: - Private properties

	// Список блюд в корзине.
	private var dishes = [Dish]()

	// MARK: - Lifecycle

	private init() {}

	// MARK: - Internal methods

	// Отображение содержимого корзины.
	func showCart() -> [Dish] {
		dishes
	}

	// Общая стоимость блюд в корзине.
	func getTotalPrice() -> Int {
		dishes.reduce(0) { $0 + $1.price * $1.quantity }
	}

	// MARK: - Private methods

	// Добавление товара в корзину.
	private func addProduct(product: Dish) {
		dishes.append(product)
	}

	// Удаление блюда из корзины.
	private func removeProduct(product: Dish) {
		if let index = dishes.firstIndex(where: { $0.name == product.name }) {
			dishes.remove(at: index)
		}
	}

	// Увеличения количества блюда в корзине.
	func increaseQuantity(product: Dish) {
		if let index = dishes.firstIndex(where: { $0.name == product.name }) {
			dishes[index].quantity += 1
		} else {
			dishes.append(product)
		}
		// Отправляем уведомление о том, что корзина была обновлена
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: L10n.NotificationCenter.cartUpdated), object: nil)
	}

	// Уменьшения количества блюда в корзине.
	func decreaseQuantity(product: Dish) {
		if let index = dishes.firstIndex(where: { $0.name == product.name }) {
			dishes[index].quantity -= 1
			if dishes[index].quantity == 0 {
				removeProduct(product: product)
			}
		}
	}

	// Очистить корзину с заказом.
	func emptyCart() {
		dishes = [Dish]()
	}
}
