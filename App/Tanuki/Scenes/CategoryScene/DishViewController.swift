//
//  DishViewController.swift
//  Tanuki
//
//  Created by Constantin on 06.07.2023.
//

import UIKit

final class DishViewController: UIViewController {

	// MARK: - Internal properties

	weak var delegate: TableViewCellDelegate?

	// MARK: - Private properties

	private let dish: Dish

	private lazy var buttonCart: UIButton = {
		let button = UIButton()
		button.configuration = .filled()
		button.setTitle(L10n.Button.addCart, for: .normal)
		button.addTarget(self, action: #selector(buttonCartTapped), for: .touchUpInside)

		return button
	}()

	private lazy var buttonHeart: UIButton = {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.baseForegroundColor = Theme.black
		button.tintColor = Theme.backgroundColor
		button.setImage( UIImage(systemName: L10n.SystemImage.heart), for: .normal)
		button.addTarget(self, action: #selector(buttonHeartTapped(_:)), for: .touchUpInside)

		return button
	}()

	private lazy var buttonXmark: UIButton = {
		let button = UIButton()
		button.configuration = .filled()
		button.configuration?.baseForegroundColor = .black
		button.tintColor = Theme.backgroundColor
		button.setImage( UIImage(systemName: L10n.SystemImage.xmark), for: .normal)
		button.addTarget(self, action: #selector(buttonXmarkTapped), for: .touchUpInside)

		return button
	}()

	private let stackViewMain: UIStackView = {
		let stackView = UIStackView()
		stackView.backgroundColor = Theme.backgroundColor
		stackView.spacing = Sizes.Medium.halfpadding
		stackView.axis = .vertical
		stackView.layer.cornerRadius = Sizes.Medium.cornerRadius
		stackView.layoutMargins = UIEdgeInsets(
			top: Sizes.Medium.padding,
			left: Sizes.Medium.padding,
			bottom: Sizes.Medium.padding,
			right: Sizes.Medium.padding
		)
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private let stackViewHorizontal: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .leading

		return stackView
	}()

	private let stackViewButtons: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = Sizes.Medium.halfpadding
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = Theme.accentColor
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = Sizes.Medium.cornerRadius
		imageView.isUserInteractionEnabled = true

		return imageView
	}()

	private let name: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}()

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .callout)
		label.textColor = Theme.black
		label.alpha = Sizes.Alfa.viewController
		label.numberOfLines = 0

		return label
	}()

	private let price: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = Theme.black

		return label
	}()

	private let weight: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = Theme.black
		label.alpha = Sizes.Alfa.text

		return label
	}()

	private var isFavorite = false

	// MARK: - Lifecycle

	init(_ dish: Dish) {
		self.dish = dish
		self.imageView.image = dish.getImage()
		self.name.text = dish.name.filterN()
		self.descriptionLabel.text = dish.description
		self.price.text = String(dish.price) + L10n.Location.currency
		self.weight.text = L10n.Location.separator + String(dish.weight) + L10n.Location.unit
		self.isFavorite = dish.isFavorite
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
	}

	// MARK: - Private methods

	private func setupView() {
		view.backgroundColor = Theme.black.withAlphaComponent(Sizes.Alfa.text)
		view.addSubview(stackViewMain)
		imageView.addSubview(stackViewButtons)
		stackViewButtons.addArrangedSubviews([buttonHeart, buttonXmark])
		stackViewHorizontal.addArrangedSubviews([price, weight])
		stackViewMain
			.addArrangedSubviews([
				imageView,
				name,
				stackViewHorizontal,
				descriptionLabel,
				buttonCart
			])

		NSLayoutConstraint.activate([
			stackViewButtons.topAnchor.constraint(
				equalTo: imageView.topAnchor,
				constant: Sizes.Medium.padding
			),
			stackViewButtons.trailingAnchor.constraint(
				equalTo: imageView.trailingAnchor,
				constant: -Sizes.Medium.padding
			),
			stackViewMain.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Sizes.Medium.padding
			),
			stackViewMain.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Sizes.Medium.padding
			),
			stackViewMain.centerYAnchor.constraint(
				equalTo: view.centerYAnchor
			),
			imageView.heightAnchor.constraint(
				equalToConstant: Sizes.Medium.image
			)
		])
	}

	// MARK: - Actions

	@objc private func buttonHeartTapped(_ sender: UIButton) {
		if isFavorite == true {
			buttonHeart.setImage( UIImage(systemName: L10n.SystemImage.heart), for: .normal)
			buttonHeart.configuration?.baseForegroundColor = Theme.black
			isFavorite.toggle()
		} else {
			buttonHeart.setImage( UIImage(systemName: L10n.SystemImage.heartFill), for: .normal)
			buttonHeart.configuration?.baseForegroundColor = Theme.red
			isFavorite.toggle()
		}
	}

	@objc private func buttonXmarkTapped() {
		dismiss(animated: true, completion: nil)
	}

	@objc private func buttonCartTapped() {
		Cart.shared.increaseQuantity(product: dish)
		dismiss(animated: true, completion: nil)
	}
}
