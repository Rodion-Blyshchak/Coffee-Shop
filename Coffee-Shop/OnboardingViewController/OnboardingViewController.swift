//
//  OnboardingViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

class OnboardingViewController: UIViewController {
	private let storageManager: OnboardingStorageManagerProtocol
	
	// Кнопка буде перероблена, зараз акцент на переході на HomeViewController та роботі з UserDefaults
	private let btn: UIButton = {
		let btn = UIButton()
		btn.setTitle("Continue", for: .normal)
		btn.setTitleColor(.white, for: .normal)
		btn.backgroundColor = .systemBlue
		btn.layer.cornerRadius = 10
		btn.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
		return btn
	}()
	
	init(storageManager: OnboardingStorageManagerProtocol) {
		self.storageManager = storageManager
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .mainBlack
		view.addSubview(btn)
		
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
	}
	
	@objc func didTapGetStarted() {
		storageManager.checkUserStatus()
		
		guard let window = view.window else { return }
		let homeViewController = HomeViewController()
		
		UIView.transition(with: window,
						  duration: 0.4,
						  options: .transitionCrossDissolve,
						  animations: {
			window.rootViewController = homeViewController
		}, completion: nil)
	}
}
