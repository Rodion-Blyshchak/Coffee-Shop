//
//  HomeViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

class HomeViewController: UIViewController {
	// MARK: - Properties
	private let fullCoffeeList: [CollectionViewCellViewModel] = [
		CollectionViewCellViewModel(
			id: 1,
			productImageView: UIImageView(image: UIImage(named: "bannerCoffeeCup")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: 4.8,
			titleLabel: "Caffe Mocha",
			subtitleLabel: "with Chocolate",
			descriptionContent: "A mocha, also known as a caffe mocha, is a chocolate-flavored variant of a caffe latte, typically served in a glass rather than a mug. It consists of espresso, warm milk, and cocoa powder or chocolate syrup.",
			price: 4.53,
			categoryFilter: "Machiato"
		),
		CollectionViewCellViewModel(
			id: 2,
			productImageView: UIImageView(image: UIImage(named: "bannerMorningEspresso")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: 4.2,
			titleLabel: "Flat White",
			subtitleLabel: "with Oat Milk",
			descriptionContent: "A flat white is an espresso-based coffee drink accompanied by steamed milk with a velvety texture and a thin layer of microfoam. It is perfect for those who appreciate a strong coffee flavor with a smooth finish.",
			price: 2.3,
			categoryFilter: "Latte"
		),
		CollectionViewCellViewModel(
			id: 3,
			productImageView: UIImageView(image: UIImage(named: "DefaultBannerImage")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: 3.8,
			titleLabel: "Americano",
			subtitleLabel: "Classic Black",
			descriptionContent: "Caffè Americano is a type of coffee drink prepared by diluting an espresso with hot water, giving it a similar strength to, but different flavor from, traditionally brewed coffee. Simple, elegant, and energizing.",
			price: 3.0,
			categoryFilter: "Americano"
		)
	]
	
	private var filteredCoffeeList: [CollectionViewCellViewModel] = []
	private let verticalScroll = ScrollContainerView(direction: .vertical)
	private let locationSelectorView = LocationSelectorView()
	private let searchBarView = SearchBarView()
	private let bannerViewController = BannerViewController()
	private let coffeeCollectionView = CoffeeCollectionView()
	private let categoryFilterView = CategoryFilterView()
	private var activeCategory: String = "All Coffee"
	private var currentSearchText: String = ""
	
	private var coffeeCollectionHeightConstraint: NSLayoutConstraint?
	
	private let verticalStackHeaderView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = Constraint.tiny
		return stackView
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Colors.background
		filteredCoffeeList = fullCoffeeList
		
		let tapOutsideKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		tapOutsideKeyboard.cancelsTouchesInView = false
		view.addGestureRecognizer(tapOutsideKeyboard)
		
		setupScrollView()
		locationSelectorView.delegate = self
		searchBarView.delegate = self
		categoryFilterView.filterDelegate = self
		
		setupVerticalStackHeaderView()
		setupDynamicFilters()
		
		coffeeCollectionView.isScrollEnabled = false
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		coffeeCollectionView.collectionViewLayout.invalidateLayout()
		coffeeCollectionView.layoutIfNeeded()
		coffeeCollectionHeightConstraint?.constant = coffeeCollectionView.collectionViewLayout.collectionViewContentSize.height
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	// MARK: - Setup
	private func setupScrollView() {
		view.addSubview(verticalScroll)
		
		NSLayoutConstraint.activate([
			verticalScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			verticalScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			verticalScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			verticalScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupVerticalStackHeaderView() {
		addChild(bannerViewController)
		
		verticalScroll.contentView.addSubview(verticalStackHeaderView)
		verticalScroll.contentView.addSubview(coffeeCollectionView)
		
		verticalStackHeaderView.translatesAutoresizingMaskIntoConstraints = false
		coffeeCollectionView.translatesAutoresizingMaskIntoConstraints = false
		
		coffeeCollectionView.delegate = self
		coffeeCollectionView.dataSource = self
		
		coffeeCollectionHeightConstraint = coffeeCollectionView.heightAnchor.constraint(equalToConstant: 0)
		coffeeCollectionHeightConstraint?.isActive = true
		
		verticalStackHeaderView.addArrangedSubview(locationSelectorView)
		verticalStackHeaderView.addArrangedSubview(searchBarView)
		verticalStackHeaderView.addArrangedSubview(bannerViewController.view)
		verticalStackHeaderView.addArrangedSubview(categoryFilterView)
		
		verticalStackHeaderView.setCustomSpacing(Constraint.small, after: bannerViewController.view)
		bannerViewController.didMove(toParent: self)

		NSLayoutConstraint.activate([
			verticalStackHeaderView.topAnchor.constraint(equalTo: verticalScroll.contentView.topAnchor, constant: Constraint.small),
			verticalStackHeaderView.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor),
			verticalStackHeaderView.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor),
			
			bannerViewController.view.heightAnchor.constraint(equalToConstant: ScreenSizeHelper.heightMultiplier(0.2)),
			categoryFilterView.heightAnchor.constraint(equalToConstant: Constraint.xxxLarge),
			
			coffeeCollectionView.topAnchor.constraint(equalTo: verticalStackHeaderView.bottomAnchor),
			coffeeCollectionView.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor),
			coffeeCollectionView.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor),

			coffeeCollectionView.bottomAnchor.constraint(equalTo: verticalScroll.contentView.bottomAnchor)
		])
	}
	
	// MARK: - Filter logic
	private func setupDynamicFilters() {
		let rawCategories = fullCoffeeList.map{ $0.categoryFilter }
		let uniqueCategories = Array(Set(rawCategories)).sorted()
		
		if uniqueCategories.isEmpty || uniqueCategories.count == 1 {
			categoryFilterView.isHidden = true
			return
		}
		
		let finalCategories = ["All Coffee"] + uniqueCategories
		
		categoryFilterView.isHidden = false
		categoryFilterView.updateCategories(newCategories: finalCategories)
	}
	
	private func applyCombinedFilters() {
		filteredCoffeeList = fullCoffeeList.filter { coffee in
			let matchesCategory = (activeCategory == "All Coffee") || (coffee.categoryFilter == activeCategory)
			
			let matchesSearch = currentSearchText.isEmpty ||
			coffee.titleLabel.lowercased().contains(currentSearchText.lowercased()) ||
			coffee.descriptionContent.lowercased().contains(currentSearchText.lowercased())
			
			return matchesCategory && matchesSearch
		}
		
		coffeeCollectionView.updateData()
		view.setNeedsLayout()
	}
}

// MARK: - Extensions
extension HomeViewController: LocationSelectorDelegate {
	func didTapLocationSelector() {
		locationSelectorView.animateChevron(isOpened: true)
		let alert = UIAlertController(title: "Select City", message: nil, preferredStyle: .actionSheet)
		
		let cities = ["Kyiv", "Lviv", "Odesa", "Kharkiv", "Dnipro"]
		
		for city in cities {
			let action = UIAlertAction(title: city, style: .default) { _ in
				self.locationSelectorView.animateChevron(isOpened: false)
				self.locationSelectorView.updateLocationText(to: city)
			}
			alert.addAction(action)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
			self.locationSelectorView.animateChevron(isOpened: false)
		}
		alert.addAction(cancelAction)
		present(alert, animated: true)
	}
}

extension HomeViewController: SearchBarViewDelegate {
	func searchBarView(_ searchBarView: SearchBarView, didChangeSearchText text: String) {
		currentSearchText = text
		applyCombinedFilters()
	}
}

extension HomeViewController: CategoryFilterViewDelegate {
	func categoryFilterView(_ filterView: CategoryFilterView, didSelectCategory category: String) {
		activeCategory = category
		applyCombinedFilters()
	}
}

extension HomeViewController: CoffeeCollectionViewCellDelegate {
	func didTapButtonAction(in cell: CoffeeCollectionViewCell) {
		guard let indexPath = coffeeCollectionView.indexPath(for: cell) else { return }
		let selectedCoffee = filteredCoffeeList[indexPath.item]
		
		print("+, ID: \(selectedCoffee.id)")
	}
	
	func didSelectCoffeeCell(in cell: CoffeeCollectionViewCell) {
		guard let indexPath = coffeeCollectionView.indexPath(for: cell) else { return }
		let selectedCoffee = filteredCoffeeList[indexPath.item]
		let descriptionViewController = DetailCardViewController()
		
		let detailModel = DetailCardViewModel(
			id: selectedCoffee.id,
			productImageView: selectedCoffee.productImageView.image ?? UIImage(named: "bannerCoffeeCup"),
			title: selectedCoffee.titleLabel,
			subtitle: selectedCoffee.subtitleLabel,
			rating: Double(selectedCoffee.ratingLabel),
			descriptionContent: selectedCoffee.descriptionContent,
			availableSizes: "M",
			titlePrice: "Price",
			price: selectedCoffee.price
		)
		
		descriptionViewController.viewModel = detailModel
		
		navigationController?.pushViewController(descriptionViewController, animated: true)
	}
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.filteredCoffeeList.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeCollectionViewCell.reuseId, for: indexPath) as? CoffeeCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let viewModel = filteredCoffeeList[indexPath.item]
		cell.configure(with: viewModel)
		
		cell.delegate = self
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? CoffeeCollectionViewCell {
			self.didSelectCoffeeCell(in: cell)
		}
	}
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widthView = collectionView.bounds.width
		let totalInsets = Constraint.xSmall * 2
		let spacing = Constraint.xSmall
		let targetWidth = (widthView - spacing - totalInsets) / 2
		let sizingCell = CoffeeCollectionViewCell()
		
		let viewModel = filteredCoffeeList[indexPath.item]
		sizingCell.configure(with: viewModel)
		
		let targetSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
		let autoSize = sizingCell.contentView.systemLayoutSizeFitting(
			targetSize,
			withHorizontalFittingPriority: .required,
			verticalFittingPriority: .fittingSizeLevel
		)
		
		return CGSize(width: targetWidth, height: autoSize.height)
	}
}

