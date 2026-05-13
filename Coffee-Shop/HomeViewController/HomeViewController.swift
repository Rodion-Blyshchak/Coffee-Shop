//
//  HomeViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

class HomeViewController: UIViewController {
	// MARK: - Properties
	private let bannerViewController = BannerViewController()
	private let locationSelectorView = LocationSelectorView()
	private let collectionCoffeCollectionView = CollectionCoffeCollectionView()
	
	private let verticalStackHeaderView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = Constraint.large
		return stackView
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Colors.mainBackground
		
		locationSelectorView.delegate = self
		setupVerticalStackHeaderView()
		setupCollectionCoffeStackView()
	}
	
	// MARK: - Setup
	private func setupVerticalStackHeaderView() {
		view.addSubview(verticalStackHeaderView)
		verticalStackHeaderView.translatesAutoresizingMaskIntoConstraints = false
		
		verticalStackHeaderView.addArrangedSubview(locationSelectorView)
		verticalStackHeaderView.addArrangedSubview(bannerViewController.view)
		
		NSLayoutConstraint.activate([
			verticalStackHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraint.small),
			verticalStackHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			verticalStackHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			
			bannerViewController.view.heightAnchor.constraint(equalToConstant: Constraint.mega)
		])
	}
	
	private func setupCollectionCoffeStackView() {
		view.addSubview(collectionCoffeCollectionView)
		collectionCoffeCollectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionCoffeCollectionView.topAnchor.constraint(equalTo: verticalStackHeaderView.bottomAnchor, constant: Constraint.small),
			collectionCoffeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionCoffeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionCoffeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
