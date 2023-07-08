//
//  CartViewController.swift
//  Tanuki
//
//  Created by Constantin on 03.07.2023.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
	func updateTable()
	func updateCart()
}

final class CartViewController: UIViewController {

	// MARK: - Private properties

	private lazy var buttonCart: UIButton = {
		let button = UIButton()
		button.configuration = .filled()
		button.setTitle(
			L10n.Button.pay +
			L10n.Location.whitespace +
			String(Cart.shared.getTotalPrice()) +
			L10n.Location.whitespace +
			L10n.Location.currency,
			for: .normal
		)
		button.addTarget(self, action: #selector(buttonCartTapped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.backgroundColor = Theme.backgroundColor
		tableView.separatorStyle = .none
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(CartCell.self, forCellReuseIdentifier: L10n.Cell.cart)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	private let navigationItemView = NavigationItemView()

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		NotificationCenter
			.default
			.addObserver(
				self,
				selector: #selector(updateCart),
				name: NSNotification.Name(rawValue: L10n.NotificationCenter.cartUpdated),
				object: nil
			)

		setupNavigationItem()
		setupView()
	}

	// MARK: - Private methods

	private func setupNavigationItem() {
		navigationItem.titleView = navigationItemView.titleView()
		navigationItem.rightBarButtonItem = navigationItemView.barButtonItem()
	}

	private func setupView() {
		view.backgroundColor = Theme.backgroundColor
		view.addSubviews([tableView, buttonCart])
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(
				equalTo: buttonCart.topAnchor,
				constant: -Sizes.Medium.padding
			),
			buttonCart.leadingAnchor.constraint(
				equalTo: view.leadingAnchor,
				constant: Sizes.Medium.padding
			),
			buttonCart.trailingAnchor.constraint(
				equalTo: view.trailingAnchor,
				constant: -Sizes.Medium.padding
			),
			buttonCart.bottomAnchor.constraint(
				equalTo: view.safeAreaLayoutGuide.bottomAnchor,
				constant: -Sizes.Medium.padding
			)
		])
	}

	// MARK: - Actions

	@objc private func buttonCartTapped() {
		let alertController = UIAlertController(title: L10n.Cart.number, message: L10n.Cart.order, preferredStyle: .alert)

		let okAction = UIAlertAction(title: L10n.Cart.ok, style: .default) { [self] _ in
			Cart.shared.emptyCart()
			updateCart()
		}

		alertController.addAction(okAction)

		present(alertController, animated: true, completion: nil)
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

	// MARK: - Internal methods

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		Cart.shared.showCart().count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: L10n.Cell.cart, for: indexPath) as? CartCell
		else {
			fatalError(L10n.FatalError.cell)
		}

		let cart = Cart.shared.showCart()[indexPath.row]
		cell.imageCart.image = cart.image
		cell.name.text = cart.name
		cell.price.text = String(cart.price) + L10n.Location.currency
		cell.weight.text = L10n.Location.separator + String(cart.weight) + L10n.Location.unit
		cell.quantity.text = String(cart.quantity)
		cell.delegate = self
		cell.configure(indexPath: indexPath)
		return cell
	}
}

// MARK: - TableViewCellDelegate

extension CartViewController: TableViewCellDelegate {

	// MARK: - Internal methods

	func updateTable() {
		tableView.reloadData()	}

	// MARK: - Actions

	@objc func updateCart() {
		updateTable()
		buttonCart.setTitle(
			L10n.Button.pay +
			L10n.Location.whitespace +
			String(Cart.shared.getTotalPrice()) +
			L10n.Location.whitespace +
			L10n.Location.currency,
			for: .normal
		)
	}
}
