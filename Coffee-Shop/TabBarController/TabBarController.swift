//
//  TabBarController.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class TabBarController: UITabBarController {
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setTabs()
	}
	
	// MARK: - SetTabs
	private func setTabs() {
		let homeViewController = createViewController(
			rootViewController: HomeViewController(),
			image: .init(systemName: "house.fill"),
			tag: 0,
			navigationControllerRequired: true
		)
		setViewControllers([homeViewController], animated: true)
	}
	
	private func createViewController(
		rootViewController: UIViewController,
		image: UIImage?,
		tag: Int,
		navigationControllerRequired: Bool) -> UIViewController {
			let navigationController = UINavigationController(rootViewController: rootViewController)
			navigationController.isNavigationBarHidden = true
			
			navigationController.tabBarItem = UITabBarItem(title: nil, image: image, tag: tag)
			return navigationController
		}
}
