//
//  HomeViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

class HomeViewController: UIViewController {
	private let bannerViewController = BannerViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Colors.mainBackground
		
		setupBanner()
	}
	
	private func setupBanner() {
		view.addSubview(bannerViewController.view)
		bannerViewController.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			bannerViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			bannerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			bannerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			bannerViewController.view.heightAnchor.constraint(equalToConstant: 160)
		])
	}
}

