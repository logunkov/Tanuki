//
//  MenuAdapter.swift
//  Tanuki
//
//  Created by Constantin on 06.07.2023.
//

protocol IMenuAdapter {
	func getAllMenu() -> [Dish]
	func getSaladMenu() -> [Dish]
	func getRiceMenu() -> [Dish]
	func getFishMenu() -> [Dish]
	func getRollMenu() -> [Dish]
}

// Адаптер меню.
final class MenuAdapter: IMenuAdapter {

	// MARK: - Private Properties

	// Меню.
	private let menu: [Dish]

	// MARK: - Lifecycle

	init() {
		menu = MenuRepository.shared.getMenu()
	}

	// MARK: - Internal Methods

	// Получить меню.
	func getAllMenu() -> [Dish] {
		menu
	}

	// Получить меню с салатами.
	func getSaladMenu() -> [Dish] {
		menu.filter { $0.tag.contains( L10n.Tag.salad ) }
	}
	// Получить меню с рисом.
	func getRiceMenu() -> [Dish] {
		menu.filter { $0.tag.contains( L10n.Tag.rice ) }
	}

	// Получить меню с рыбой.
	func getFishMenu() -> [Dish] {
		menu.filter { $0.tag.contains( L10n.Tag.fish ) }
	}

	// Получить меню с роллами.
	func getRollMenu() -> [Dish] {
		menu.filter { $0.tag.contains( L10n.Tag.roll ) }
	}
}
