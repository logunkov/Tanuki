//
//  DishViewController.swift
//  Tanuki
//
//  Created by Constantin on 04.07.2023.
//

import UIKit

protocol ICategoryViewControllerDelegate: AnyObject {
	func pressButtom(_ sender: UIButton)
}

protocol ICategoryViewController: AnyObject {
	func navigateTo(scene: UIViewController)
}

final class CategoryViewController: UIViewController {

	// MARK: - Internal Properties

	var presenter: ICategoryPresenter?

	// MARK: - Private Properties

	private let titleText: String?

	private var layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = Sizes.Table.spacing
		layout.minimumInteritemSpacing = Sizes.Table.spacing
		layout.sectionInsetReference = .fromContentInset

		return layout
	}()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(
			CategoryCell.self,
			forCellWithReuseIdentifier: L10n.Cell.category
		)
		collectionView.register(
			CategoryHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: L10n.Cell.categoryHeader
		)

		return collectionView
	}()

	private let navigationItemView = NavigationItemView()
	private var menuRepository: IMenuAdapter
	private var menu: [Dish]

	// MARK: - Life Cycle

	init(titleText: String?) {
		self.titleText = titleText

		// Заполняем меню.
		menuRepository = MenuAdapter()
		menu = menuRepository.getAllMenu()

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		presenter = CategoryPresenter(view: self)

		setupNavigationItem()
		setupView()
	}

	// MARK: - Private methods

	private func setupNavigationItem() {
		navigationItem.title = titleText
		navigationItem.rightBarButtonItem = navigationItemView.barButtonItem()
	}

	private func setupView() {
		view.addSubview(collectionView)
		view.backgroundColor = Theme.backgroundColor
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	// MARK: - Internal methods

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		menu.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: L10n.Cell.category, for: indexPath) as? CategoryCell
		else {
			fatalError(L10n.FatalError.cell)
		}
		cell.imageView.image = menu[indexPath.item].image
		cell.label.text = menu[indexPath.item].name

		return cell
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		let size: CGFloat = Sizes.Table.spacing

		return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let  spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
		return imageSize(for: collectionView.frame.width, with: spacing ?? 0)
	}

	private func imageSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
		let width = floor((width - 4 * spacing) / Sizes.Table.numberOfCell)

		return CGSize(width: width, height: Sizes.Table.proportions * width)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForHeaderInSection section: Int
	) -> CGSize {
		if section == 0 || section == collectionView.numberOfSections - 1 {
			return CGSize(width: collectionView.bounds.width, height: Sizes.Table.height)
		}
		return CGSize.zero
	}

	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			if indexPath.section == 0 || indexPath.section == collectionView.numberOfSections - 1 {
				guard let headerView = collectionView
					.dequeueReusableSupplementaryView(
						ofKind: kind,
						withReuseIdentifier: L10n.Cell.categoryHeader,
						for: indexPath
					) as? CategoryHeaderView
				else { fatalError(L10n.FatalError.cell) }
				headerView.delegate = self

				return headerView
			}
		}
		return UICollectionReusableView()
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter?.navigateToNextScene(dish: menu[indexPath.item])
	}
}

// MARK: - ICategoryViewControllerDelegate

extension CategoryViewController: ICategoryViewControllerDelegate {

	// MARK: - Internal methods

	func pressButtom(_ sender: UIButton) {
		let title = sender.titleLabel?.text

		switch title {
		case L10n.Tag.all:
			menu = menuRepository.getAllMenu()
		case L10n.Tag.salad:
			menu = menuRepository.getSaladMenu()
		case L10n.Tag.rice:
			menu = menuRepository.getRiceMenu()
		case L10n.Tag.fish:
			menu = menuRepository.getFishMenu()
		case L10n.Tag.roll:
			menu = menuRepository.getRollMenu()
		default:
			menu = menuRepository.getAllMenu()
		}

		collectionView.reloadData()
	}
}

// MARK: - ICategoryViewController

extension CategoryViewController: ICategoryViewController {

	// MARK: - Internal Methods

	// Переход к сцене с блюдом.
	func navigateTo(scene: UIViewController) {
		navigationController?.pushViewController(scene, animated: true)
	}
}
