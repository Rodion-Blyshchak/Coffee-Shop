//
//  Colors.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 14.04.2026.
//

import UIKit

enum Colors {
	static let brandOrange = UIColor(named: "brandOrange") ?? .orange
	
	static let mainBackground = UIColor(named: "milkCream") ?? .white
	static let secondaryBackground = UIColor(named: "softBeige") ?? .systemGray6
	static let background = UIColor.systemBackground
	
	static let primaryText = UIColor(named: "dynamicBlackAndWhite") ?? .label
	static let secondaryText = UIColor.secondaryLabel
	
	static let lightGrey = UIColor(named: "appLightGrey") ?? .systemGray
	static let silver = UIColor(named: "lightSilver") ?? .lightGray
	static let black = UIColor(named: "mainBlack") ?? .black
	static let white = UIColor.white
	
	static let buttonDisabled = UIColor.systemGray4
	static let error = UIColor.systemRed
	static let success = UIColor.systemGreen
}
