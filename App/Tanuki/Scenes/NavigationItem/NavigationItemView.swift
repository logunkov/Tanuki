//
//  NavigationItemView.swift
//  Tanuki
//
//  Created by Constantin on 04.07.2023.
//

import UIKit

final class NavigationItemView {

	// MARK: - Private Properties

	private let currentLocation = CurrentLocation()
	private let image = UIImageView(image: UIImage(systemName: L10n.SystemImage.location))

	private let stackViewVertical: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private let stackViewHorizontal: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .top
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	// MARK: - Internal Methods

	// Создаем кастомную View для navigationItem.
	func titleView() -> UIView {
		let view = UIView()

		view.addSubview(stackViewHorizontal)
		stackViewHorizontal.addArrangedSubviews([image, stackViewVertical])
		stackViewVertical.addArrangedSubviews([createLabelCity(), createLabelDate()])

		NSLayoutConstraint.activate([
			image.widthAnchor.constraint(equalToConstant: Sizes.Medium.location),
			image.heightAnchor.constraint(equalToConstant: Sizes.Medium.location)
		])

		return view
	}

	// Создаем иконку для navigationItem.
	func barButtonItem() -> UIBarButtonItem {
		let imageView = UIImageView(image: Asset.SupportingFiles.profilePicture.image)
		imageView.frame = CGRect(x: 0, y: 0, width: Sizes.Medium.avatar, height: Sizes.Medium.avatar)
		imageView.contentMode = .scaleAspectFit
		return UIBarButtonItem(customView: imageView)
	}

	// MARK: - Private Methods

	// Создаем label для города.
	private func createLabelCity () -> UILabel {
		let label = UILabel()
		label.text = currentLocation.currentCity()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = Theme.black
		return label
	}

	// Создаем label для даты.
	private func createLabelDate () -> UILabel {
		let label = UILabel()
		label.text = currentLocation.currentDate()
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)
		label.textColor = Theme.black
		label.alpha = Sizes.Alfa.text
		return label
	}
}
