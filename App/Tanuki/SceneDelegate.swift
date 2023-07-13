//
//  SceneDelegate.swift
//  Tanuki
//
//  Created by Constantin on 03.07.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	// Создаем сцену.
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {

		// Загрузка меню.
		MenuRepository.shared.fetchMenu()

		// Проверяем, что сцена является окном.
		guard let winScene = (scene as? UIWindowScene) else { return }

		// Устанавливаем корневой контроллер - таббар.
		let window = UIWindow(windowScene: winScene)
		window.rootViewController = createTabBar()
		window.makeKeyAndVisible()
		self.window = window
	}

	// Создаем таббар и добавляем в него контроллеры сцен.
	func createTabBar() -> UITabBarController {
		let tabBar = UITabBarController()
		tabBar.viewControllers = [
			createMainScene(),
			createSearchScene(),
			createCartScene(),
			createAccountScene()
		]
		return tabBar
	}

	// Создаем контроллер главной сцены.
	func createMainScene() -> UINavigationController {
		let nvc = UINavigationController(rootViewController: MainAssembler().assembly())
		nvc.tabBarItem = UITabBarItem(
			title: L10n.TabBar.main,
			image: UIImage(systemName: L10n.SystemImage.main),
			tag: 0
		)
		return nvc
	}

	// Создаем контроллер сцены поиска.
	func createSearchScene() -> UINavigationController {
		let nvc = UINavigationController(rootViewController: SearchAssembler().assembly())
		nvc.tabBarItem = UITabBarItem(
			title: L10n.TabBar.search,
			image: UIImage(systemName: L10n.SystemImage.search),
			tag: 1
		)
		return nvc
	}

	// Создаем контроллер сцены корзины.
	func createCartScene() -> UINavigationController {
		let nvc = UINavigationController(rootViewController: CartAssembler().assembly())
		nvc.tabBarItem = UITabBarItem(
			title: L10n.TabBar.cart,
			image: UIImage(systemName: L10n.SystemImage.cart),
			tag: 2
		)
		return nvc
	}

	// Создаем контроллер сцены аккаунта.
	func createAccountScene() -> UINavigationController {
		let nvc = UINavigationController(rootViewController: AccountAssembler().assembly())
		nvc.tabBarItem = UITabBarItem(
			title: L10n.TabBar.account,
			image: UIImage(systemName: L10n.SystemImage.account),
			tag: 3
		)
		return nvc
	}
}
