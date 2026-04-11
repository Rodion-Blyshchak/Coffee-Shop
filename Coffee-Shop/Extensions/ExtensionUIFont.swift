//
//  ExtensionUIFont.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

extension UIFont {
	enum Sora: String {
		case thin = "Sora-Thin"
		case extraLight = "Sora-ExtraLight"
		case light = "Sora-Light"
		case regular = "Sora-Regular"
		case medium = "Sora-Medium"
		case semiBold = "Sora-SemiBold"
		case bold = "Sora-Bold"
		case extraBold = "Sora-ExtraBold"
	}
	
	static func sora(size: CGFloat, weight: Sora) -> UIFont {
		let font = UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size)
		
		return UIFontMetrics.default.scaledFont(for: font)
	}
	
	// 	text1.font = .sora(size: 30, weight: .extraBold)
}
