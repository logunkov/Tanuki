//
//  CategoryCell.swift
//  Tanuki
//
//  Created by Constantin on 05.07.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

	// MARK: - Internal Properties

	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false

		return imageView
	}()

	let label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .caption1)

		return label
	}()

	// MARK: - Private Properties

	private let stackViewVertical: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}()

	// MARK: - Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.accentColor
		layer.cornerRadius = Sizes.Medium.cornerRadius

		stackViewVertical.addArrangedSubviews([imageView, label])
		contentView.addSubview(stackViewVertical)

		NSLayoutConstraint.activate([
			stackViewVertical.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Sizes.Medium.halfpadding
			),
			stackViewVertical.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Sizes.Medium.halfpadding
			),
			stackViewVertical.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Sizes.Medium.halfpadding
			),
			stackViewVertical.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Sizes.Medium.halfpadding
			)
		])
	}
}
