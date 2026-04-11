//
//  OnboardingStorageManager.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

protocol OnboardingStorageManagerProtocol {
	func checkUserStatus()
}

class OnboardingStorageManager: OnboardingStorageManagerProtocol {
	private let userDefaults: UserDefaults
	private let onboardingCompletedKey = "onboardingCompleted"
	
	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
	}
	
	var isFirstLaunch: Bool {
		return !userDefaults.bool(forKey: onboardingCompletedKey)
	}
	
	func checkUserStatus() {
		userDefaults.set(true, forKey: onboardingCompletedKey)
	}
}
