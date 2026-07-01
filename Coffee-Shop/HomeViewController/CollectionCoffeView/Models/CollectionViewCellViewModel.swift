//
//  CollectionViewCellViewModel.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 30.04.2026.
//

import UIKit

struct CollectionViewCellViewModel {
	let id: Int
	let productImageView: UIImageView
	let starIcon: UIImageView
	let ratingLabel: Double
	let titleLabel: String
	let subtitleLabel: String
	let descriptionContent: String
	let price: Double
	let categoryFilter: String
}

