//
//  AccountViewController.swift
//  Tanuki
//
//  Created by Constantin on 03.07.2023.
//

import UIKit

final class AccountViewController: UIViewController {

	// MARK: - Private Methods

	private let navigationItemView = NavigationItemView()

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Theme.backgroundColor
		navigationItem.title = L10n.TabBar.account
		navigationItem.rightBarButtonItem = navigationItemView.barButtonItem()
	}
}
