//
//  Repository.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

protocol IMenuRepository {
	func getMenu() -> [Dish]
}

// Репозиторий с меню.
final class MenuRepositoryStub: IMenuRepository {

	// MARK: - Private Properties

	// Блюда.
	private let dishes = Dishes()

	// MARK: - Internal Methods

	// Получить меню.
	func getMenu() -> [Dish] {
		var menu = [Dish]()

		menu.append(contentsOf: multiplier())
		menu.append(contentsOf: multiplier())
		menu.append(contentsOf: multiplier())

		return menu
	}

	// MARK: - Private Methods

	// Добавляем блюда в меню.
	private func multiplier() -> [Dish] {
		var menu = [Dish]()

		menu.append(dishes.dish1)
		menu.append(dishes.dish2)
		menu.append(dishes.dish3)
		menu.append(dishes.dish4)
		menu.append(dishes.dish5)
		menu.append(dishes.dish6)

		return menu
	}
}

// Блюда.
final class Dishes {

	// MARK: - Internal properties

	lazy var dish1 = Dish(
		image: Asset.Category.dish1.image,
		name: L10n.Category.dish1,
		description: descriptionDishes[1],
		tag: [L10n.Tag.rice, L10n.Tag.fish],
		price: 799,
		weight: 560
	)

	lazy var dish2 = Dish(
		image: Asset.Category.dish2.image,
		name: L10n.Category.dish2,
		description: descriptionDishes[2],
		tag: [L10n.Tag.salad],
		price: 699,
		weight: 150
	)

	lazy var dish3 = Dish(
		image: Asset.Category.dish3.image,
		name: L10n.Category.dish3,
		description: descriptionDishes[3],
		tag: [L10n.Tag.roll],
		price: 599,
		weight: 100
	)

	lazy var dish4 = Dish(
		image: Asset.Category.dish4.image,
		name: L10n.Category.dish4,
		description: descriptionDishes[4],
		tag: [L10n.Tag.salad],
		price: 499,
		weight: 200
	)

	lazy var dish5 = Dish(
		image: Asset.Category.dish5.image,
		name: L10n.Category.dish5,
		description: descriptionDishes[5],
		tag: [L10n.Tag.rice],
		price: 399,
		weight: 200
	)

	lazy var dish6 = Dish(
		image: Asset.Category.dish6.image,
		name: L10n.Category.dish6,
		description: descriptionDishes[6],
		tag: [],
		price: 299,
		weight: 150
	)

	// MARK: - Private properties

	// swiftlint:disable all
	private let descriptionDishes = [
  """
  Пустое описание.
  """,
  """
  Свежая рыба, обжаренная на сковороде с разнообразными овощами. \nПодается с приготовленным рисом.
  """,
  """
  Свежие листья салата, с добавлением разнообразных зеленых овощей. \nПодается с дрессингом на выбор.
  """,
  """
  Тонкие ломтики ветчины, завернутые в рулеты с начинкой из крем-сыра. \nПодается в холодном или горячем виде.
  """,
  """
  Салат, приготовленный по восточному рецепту, с использованием разнообразных специй и соусов.
  """,
  """
  Рис с добавлением разнообразных овощей. \nПодается как отдельное блюдо или как гарнир к мясу или рыбе.
  """,
  """
  Традиционная итальянская паста в форме больших пирожков, наполненных различными начинками. \nПодается с соусом на выбор.
  """,
	]
	// swiftlint:enable all
}
