//
//  ScreenSizeHelper.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

final class ScreenSizeHelper {
	/// Повертає повну висоту екрана пристрою
	static var screenHeight: CGFloat {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			return UIScreen.main.bounds.height // Дефолтний варіант для безпеки
		}
		return windowScene.coordinateSpace.bounds.height
	}
	
	/// Повертає повну ширину екрана пристрою
	static var screenWidth: CGFloat {
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			return UIScreen.main.bounds.width
		}
		return windowScene.coordinateSpace.bounds.width
	}
	
	/// Розраховує висоту як певну частку від екрана (наприклад, 0.25 для 1/4)
	static func heightMultiplier(_ multiplier: CGFloat) -> CGFloat {
		return screenHeight * multiplier
	}
}

// Тут зізнаюсь, код не мій, але ідея винести функціонал для задавання динамічної висоти будь-яким обʼєктам моя🫣
