//
//  CartCell.swift
//  Tanuki
//
//  Created by Constantin on 07.07.2023.
//

import UIKit

final class CartCell: UITableViewCell {

	// MARK: - Internal properties

	weak var delegate: TableViewCellDelegate?

	var imageCart: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = Theme.accentColor
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = Sizes.Medium.cornerRadius

		return imageView
	}()

	var name: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}()

	var price: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = Theme.black

		return label
	}()

	var weight: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = Theme.black
		label.alpha = Sizes.Alfa.text

		return label
	}()

	var quantity: UILabel = {
		let label = UILabel()

		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textColor = Theme.black
		return label
	}()

	// MARK: - Private properties

	private var indexPath: IndexPath?

	private lazy var minusButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = Theme.black
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: L10n.SystemImage.minus), for: .normal)
		button.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)

		return button
	}()

	private lazy var plusButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = Theme.black
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: L10n.SystemImage.plus), for: .normal)
		button.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)

		return button
	}()

	private let stackViewMain: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Sizes.Medium.doublePadding
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	private let stackViewHorizontal: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .leading

		return stackView
	}()

	private let stackViewVertical: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .leading

		return stackView
	}()

	private let stackViewStepper: UIStackView = {
		let stackView = UIStackView()
		stackView.spacing = Sizes.Medium.padding
		stackView.backgroundColor = Theme.accentColor
		stackView.axis = .horizontal
		stackView.distribution = .fill

		return stackView
	}()

	// MARK: - Life Cycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Internal methods

	func configure(indexPath: IndexPath) {
		self.indexPath = indexPath
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor

		contentView.addSubview(stackViewMain)
		stackViewStepper.addArrangedSubviews([minusButton, quantity, plusButton])
		stackViewVertical.addArrangedSubviews([name, stackViewHorizontal])
		stackViewHorizontal.addArrangedSubviews([price, weight])
		stackViewMain.addArrangedSubviews([imageCart, stackViewVertical, stackViewStepper])

		NSLayoutConstraint.activate([
			stackViewMain.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Sizes.Medium.halfpadding
			),
			stackViewMain.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Sizes.Medium.halfpadding
			),
			stackViewMain.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Sizes.Medium.halfpadding
			),
			stackViewMain.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Sizes.Medium.halfpadding
			)
		])
	}

	// MARK: - Actions

	@objc private func decrementValue() {
		guard let index = indexPath?.row else { return }
		let cart = Cart.shared.showCart()[index]

		if cart.quantity == 1 {
			Cart.shared.decreaseQuantity(product: cart)
			delegate?.updateTable()
		} else {
			Cart.shared.decreaseQuantity(product: cart)
			quantity.text = String(Cart.shared.showCart()[index].quantity)
		}

		delegate?.updateCart()
	}

	@objc private func incrementValue() {
		guard let index = indexPath?.row else { return }
		let cart = Cart.shared.showCart()[index]
		Cart.shared.increaseQuantity(product: cart)
		quantity.text = String(Cart.shared.showCart()[index].quantity)
		delegate?.updateCart()
	}
}
