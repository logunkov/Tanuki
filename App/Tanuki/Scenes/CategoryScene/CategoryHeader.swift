//
//  CategoryHeaderView.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

import UIKit

final class CategoryHeaderView: UICollectionReusableView {

	// MARK: - Internal properties

	weak var delegate: ICategoryViewControllerDelegate?

	// MARK: - Private Properties

	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView(frame: .zero)
		scrollView.alwaysBounceVertical = false
		scrollView.alwaysBounceHorizontal = true
		scrollView.bounces = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		return scrollView
	}()

	private let stackViewHorizontal: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = Sizes.Medium.halfpadding
		stackView.alignment = .fill
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private lazy var allButton = createButton(L10n.Tag.all)
	private lazy var saladButton = createButton(L10n.Tag.salad)
	private lazy var riceButton = createButton(L10n.Tag.rice)
	private lazy var fishButton = createButton(L10n.Tag.fish)
	private lazy var rollButton = createButton(L10n.Tag.roll)

	private lazy var buttons = [
		allButton,
		saladButton,
		riceButton,
		fishButton,
		rollButton
	]

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		buttonTapped(allButton)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		addSubview(scrollView)
		scrollView.addSubview(stackViewHorizontal)
		stackViewHorizontal.addArrangedSubviews([
			allButton,
			saladButton,
			riceButton,
			fishButton,
			rollButton
		])

		NSLayoutConstraint.activate([
			stackViewHorizontal.leadingAnchor.constraint(
				equalTo: scrollView.leadingAnchor,
				constant: Sizes.Medium.halfpadding
			),
			stackViewHorizontal.trailingAnchor.constraint(
				equalTo: scrollView.trailingAnchor,
				constant: -Sizes.Medium.halfpadding
			),
			stackViewHorizontal.topAnchor.constraint(
				equalTo: scrollView.topAnchor,
				constant: Sizes.Medium.halfpadding
			),
			stackViewHorizontal.bottomAnchor.constraint(
				equalTo: scrollView.bottomAnchor,
				constant: -Sizes.Medium.halfpadding
			),
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	private func createButton(_ title: String) -> UIButton {
		let button = UIButton(type: .custom)
		button.setTitle(title, for: .normal)
		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
		button.layer.cornerRadius = Sizes.Medium.cornerRadius
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	private func greyButtons(_ buttons: [UIButton]) {
		buttons.forEach { button in
			let title = button.titleLabel?.text
			button.configuration = .gray()
			button.setTitle(title, for: .normal)
			button.setTitleColor(Theme.black, for: .normal)
		}
	}

	// MARK: - Actions

	@objc private func buttonTapped(_ sender: UIButton) {
		greyButtons(buttons)
		sender.configuration = .filled()
		sender.setTitleColor(Theme.white, for: .normal)
		delegate?.pressButtom(sender)
	}
}
