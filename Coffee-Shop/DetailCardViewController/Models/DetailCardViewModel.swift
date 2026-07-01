//
//  DetailCardViewModel.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

struct DetailCardViewModel {
	let id: Int
	let productImageView: UIImage?
	
	let title: String
	let subtitle: String
	let rating: Double
	
	let descriptionContent: String
	let availableSizes: String
	
	var titlePrice: String
	let price: Double
	
	// "$ 4.53"
	var formattedPrice: String {
		return String(format: "$ ", price)
	}
}

