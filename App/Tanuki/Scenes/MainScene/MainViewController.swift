//
//  MainViewController.swift
//  Tanuki
//
//  Created by Constantin on 03.07.2023.
//

import UIKit

protocol IMainViewController: AnyObject {
	func navigateTo(scene: UIViewController)
}

final class MainViewController: UIViewController {

	// MARK: - Internal Properties

	var presenter: IMainPresenter?

	// MARK: - Private Properties

	private let navigationItemView = NavigationItemView()

	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = Sizes.Medium.padding
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private lazy var bakeryButton = createButton(
		Asset.Cuisine.bakery.image,
		title: L10n.Cuisine.bakery,
		color: Theme.Cuisine.bakery
	)

	private lazy var fastfoodButton = createButton(
		Asset.Cuisine.fastfood.image,
		title: L10n.Cuisine.fastfood,
		color: Theme.Cuisine.fastfood
	)

	private lazy var asianButton = createButton(
		Asset.Cuisine.asian.image,
		title: L10n.Cuisine.asian,
		color: Theme.Cuisine.asian
	)

	private lazy var soupsButton = createButton(
		Asset.Cuisine.soups.image,
		title: L10n.Cuisine.soups,
		color: Theme.Cuisine.soups
	)

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		presenter = MainPresenter(view: self)

		setupNavigationItem()
		setupView()
	}

	// MARK: - Private Methods

	private func setupNavigationItem() {
		navigationItem.titleView = navigationItemView.titleView()
		navigationItem.rightBarButtonItem = navigationItemView.barButtonItem()
		navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
	}

	private func setupView() {
		view.backgroundColor = Theme.backgroundColor
		view.addSubview(stackView)

		stackView.addArrangedSubviews([
			bakeryButton,
			fastfoodButton,
			asianButton,
			soupsButton
		])

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.topAnchor,
				constant: Sizes.Medium.padding
			),
			stackView.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor
			),
			stackView.leadingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.leadingAnchor,
				constant: Sizes.Medium.padding
			),
			stackView.trailingAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.trailingAnchor,
				constant: -Sizes.Medium.padding
			)
		])
	}

	private func createButton(_ image: Image, title: String, color: UIColor) -> UIButton {
		let button = UIButton()
		button.setBackgroundImage(image, for: UIControl.State.normal)
		button.setTitle(title, for: .normal)
		button.setTitleColor(Theme.black, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		button.contentHorizontalAlignment = .left
		button.contentVerticalAlignment = .top
		button.titleEdgeInsets = UIEdgeInsets(top: Sizes.Medium.padding, left: Sizes.Medium.padding, bottom: 0, right: 0)
		button.titleLabel?.numberOfLines = 0
		button.backgroundColor = color
		button.layer.cornerRadius = Sizes.Medium.cornerRadius
		button.clipsToBounds = true
		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}

	// MARK: - Actions

	@objc private func buttonTapped(_ sender: UIButton) {
		guard let titleText = sender.titleLabel?.text else { return }
		presenter?.navigateToNextScene(title: titleText.filterN())
	}
}

// MARK: - IMainViewController

extension MainViewController: IMainViewController {

	// MARK: - Internal Methods

	// Переход к сцене с блюдами.
	func navigateTo(scene: UIViewController) {
		navigationController?.pushViewController(scene, animated: true)
	}
}
