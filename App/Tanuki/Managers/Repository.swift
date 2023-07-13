//
//  Repository.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

import Foundation

// Репозиторий с меню.
final class MenuRepository {

	// MARK: - Singleton

	static var shared = MenuRepository()

	// MARK: - Private Properties

	private var dishes = [Dish]()
	private var menu = [Dish]()

	// MARK: - Lifecycle

	private init() {}

	// MARK: - Internal Methods

	// Получить меню.
	func getMenu() -> [Dish] {
		return menu
	}
	// Загрузить меню.
	func fetchMenu() {
		// Создаем URL для загрузки JSON файла
		guard let url = URL(string: L10n.Url.dishes) else { return }

		// Загружаем данные JSON файла
		let session = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
			DispatchQueue.global().async {
				guard let self = self else { return }
				guard let data = data else { return }

				do {
					// Распарсиваем данные в массив объектов.
					let dishesJSON = try JSONDecoder().decode([Dish].self, from: data)

					// Заполняем блюдами из JSON файла.
					self.dishes = dishesJSON

					self.dishes.forEach { dish in
						dish.loadImage()
					}
				} catch {
				}
				self.menu = Array(repeating: self.dishes, count: Sizes.Medium.multi).flatMap { $0 }
			}
		}
		session.resume()
	}
}
