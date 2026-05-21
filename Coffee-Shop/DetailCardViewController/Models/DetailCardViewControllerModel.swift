//
//  DetailCardViewControllerModel.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

struct DetailCardViewControllerModel {
	let id: Int
	let productImageView: UIImage?
	
	// MARK: - titleInfoLabel
	let titleInfoLabel: String
	let subTitleInfoLabel: String
	let rating: CoffeeRatingViewModel
	
	// MARK: - descriptionStackLabel
	let descriptionTitleLabel: String
	let descriptionContentLabel: String
	
	// MARK: - sizeSelectionStackView
	let availableSizes: [CoffeeSize]
	var selectedSize: CoffeeSize
	
	// MARK: - purchaseActionStackView
	var titlePriceLabel: String = "Price"
	let price: Double
	
	// MARK: - Computed Properties (Для зручного виведення в UI)
	// "$ 4.53"
	var formattedPrice: String {
		return String(format: "$ ", price)
	}
	
	// "4.8 (230)"
	var formattedRatingText: String {
		return "\(rating.score) (\(rating.reviewsCount))"
	}
}

enum CoffeeSize: String, CaseIterable {
	case small = "S"
	case medium = "M"
	case large = "L"
}

struct CoffeeRatingViewModel {
	let score: Double
	let reviewsCount: Int
}
