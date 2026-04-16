//
//  FontType.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 16.04.2026.
//

import UIKit

enum FontType {
	static let caption = UIFont.sora(size: 10, weight: .light)
	static let footnote = UIFont.sora(size: 12, weight: .regular)
	static let subHeadline = UIFont.sora(size: 14, weight: .regular)
	static let callout = UIFont.sora(size: 14, weight: .medium)
	
	static let body = UIFont.sora(size: 16, weight: .regular)
	static let button = UIFont.sora(size: 16, weight: .semiBold)
	static let headline = UIFont.sora(size: 16, weight: .semiBold)
	static let buttonLarge = UIFont.sora(size: 20, weight: .semiBold)
	
	static let smallTitle = UIFont.sora(size: 18, weight: .semiBold)
	static let subtitle = UIFont.sora(size: 20, weight: .regular)
	static let mediumTitle = UIFont.sora(size: 20, weight: .semiBold)
	static let largeTitle = UIFont.sora(size: 24, weight: .bold)
	
	static let sectionTitle = UIFont.sora(size: 32, weight: .bold)
	static let mainDisplay = UIFont.sora(size: 38, weight: .semiBold) 
	static let megaDisplay = UIFont.sora(size: 48, weight: .extraBold)
}
