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
			productImageView: UIImageView(image: UIImage(named: "DefaultBannerImage")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: "4.8",
			titleLabel: "Caffe Mocha",
			descriptionLabel: "Deep Foam",
			priceLabel: "$ 4.53"
		),
		CollectionViewCellViewModel(
			id: 2,
			productImageView: UIImageView(image: UIImage(named: "bannerMorningEspresso")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: "4.8",
			titleLabel: "Flat White",
			descriptionLabel: "Deep Foam Deep Foam Deep Foam Deep Foam",
			priceLabel: "$ 4.53"
		),
		CollectionViewCellViewModel(
			id: 3,
			productImageView: UIImageView(image: UIImage(named: "DefaultBannerImage")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: "4.8",
			titleLabel: "Americano",
			descriptionLabel: "Deep Foam",
			priceLabel: "$ 4.53"
		),
	]
	
	private let locationSelectorView = LocationSelectorView()
	private let searchBarView = SearchBarView()
	private let bannerViewController = BannerViewController()
	private let coffeeCollectionView = CoffeeCollectionView()
	
	private var coffeeCollectionHeightConstraint: NSLayoutConstraint?
	
	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.alwaysBounceVertical = true
		scroll.showsVerticalScrollIndicator = false
		return scroll
	}()
	
	private let contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
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
		//		view.backgroundColor = Colors.mainBackground
		view.backgroundColor = Colors.background
		let tapOutsideKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		tapOutsideKeyboard.cancelsTouchesInView = false
		view.addGestureRecognizer(tapOutsideKeyboard)
		
		setupScrollView()
		locationSelectorView.delegate = self
		searchBarView.delegate = self
		coffeeCollectionView.cellDelegate = self
		
		setupVerticalStackHeaderView()
		setupCollectionCoffeStackView()
		
		coffeeCollectionView.isScrollEnabled = false
		coffeeCollectionView.updateData(with: fullCoffeeList)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		coffeeCollectionHeightConstraint?.constant = coffeeCollectionView.collectionViewLayout.collectionViewContentSize.height
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	// MARK: - Setup
	private func setupScrollView() {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
		])
	}
	
	private func setupVerticalStackHeaderView() {
		contentView.addSubview(verticalStackHeaderView)
		verticalStackHeaderView.translatesAutoresizingMaskIntoConstraints = false
		
		verticalStackHeaderView.addArrangedSubview(locationSelectorView)
		verticalStackHeaderView.addArrangedSubview(searchBarView)
		verticalStackHeaderView.addArrangedSubview(bannerViewController.view)
		
		NSLayoutConstraint.activate([
			verticalStackHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.small),
			verticalStackHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			verticalStackHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			
			bannerViewController.view.heightAnchor.constraint(equalToConstant: Constraint.mega)
		])
	}
	
	private func setupCollectionCoffeStackView() {
		contentView.addSubview(coffeeCollectionView)
		coffeeCollectionView.translatesAutoresizingMaskIntoConstraints = false
		coffeeCollectionHeightConstraint = coffeeCollectionView.heightAnchor.constraint(equalToConstant: 0)
		coffeeCollectionHeightConstraint?.isActive = true
		
		NSLayoutConstraint.activate([
			coffeeCollectionView.topAnchor.constraint(equalTo: verticalStackHeaderView.bottomAnchor, constant: Constraint.small),
			coffeeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			coffeeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			coffeeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
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
		if text.isEmpty {
			coffeeCollectionView.updateData(with: fullCoffeeList)
		} else {
			let filteredList = fullCoffeeList.filter { coffee in
				coffee.titleLabel.lowercased().contains(text.lowercased()) ||
				coffee.descriptionLabel.lowercased().contains(text.lowercased())
			}
			coffeeCollectionView.updateData(with: filteredList)
		}
		view.setNeedsLayout()
	}
}

extension HomeViewController: CoffeeCollectionViewCellDelegate {
	func didTapButtonAction(in cell: CoffeeCollectionViewCell) {
		guard let indexPath = coffeeCollectionView.indexPath(for: cell) else { return }
		let selectedCoffee = fullCoffeeList[indexPath.item]
		
		print("+, ID: \(selectedCoffee.id)")
	}
	
	func didSelectCoffeeCell(in cell: CoffeeCollectionViewCell) {
		guard let indexPath = coffeeCollectionView.indexPath(for: cell) else { return }
		let selectedCoffee = fullCoffeeList[indexPath.item]
		let descriptionViewController = DetailCardViewController()
		
		let detailModel = DetailCardViewControllerModel(
			id: selectedCoffee.id,
			productImageView: selectedCoffee.productImageView.image ?? UIImage(named: "bannerCoffeeCup"),
			titleInfoLabel: selectedCoffee.titleLabel,
			subTitleInfoLabel: selectedCoffee.descriptionLabel,
			rating: CoffeeRatingViewModel(score: Double(selectedCoffee.ratingLabel) ?? 0.0, reviewsCount: 230), descriptionTitleLabel: "",
			descriptionContentLabel: "",
			availableSizes: [.small, .medium, .large],
			selectedSize: .medium,
			price: 4.53
		)
		
		descriptionViewController.viewModel = detailModel
		
		navigationController?.pushViewController(descriptionViewController, animated: true)
	}
}
