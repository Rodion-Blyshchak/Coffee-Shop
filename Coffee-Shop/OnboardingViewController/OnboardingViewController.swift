//
//  OnboardingViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

class OnboardingViewController: UIViewController {
	//MARK: - Properties
	private let userDefaults: UserDefaults
	private let onboardingCompletedKey = "onboardingCompleted"
	
	private var isFirstLaunch: Bool {
		return !userDefaults.bool(forKey: onboardingCompletedKey)
	}
	
	private let backgroundImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.image = UIImage(named: "Onboarding")
		return imageView
	}()
	
	private let titleLabel: UILabel = {
		let title = UILabel()
		title.translatesAutoresizingMaskIntoConstraints = false
		title.text = "Fall in Love with Coffee in Blissful Delight!"
		title.font = FontType.mainDisplay
		title.textColor = Colors.primaryText
		title.numberOfLines = 0
		title.textAlignment = .center
		return title
	}()
	
	private let descriptionLabel: UILabel = {
		let description = UILabel()
		description.translatesAutoresizingMaskIntoConstraints = false
		description.text = "Welcome to our cozy coffee corner, where every cup is a delightful for you."
		description.font = FontType.subtitle
		description.textColor = Colors.lightGrey
		description.numberOfLines = 0
		description.textAlignment = .center
		return description
	}()
	
	private let getStartedButton: UIButton = {
		let startedButton = UIButton()
		startedButton.translatesAutoresizingMaskIntoConstraints = false
		startedButton.setTitle("Get Started", for: .normal)
		startedButton.setTitleColor(Colors.white, for: .normal)
		startedButton.titleLabel?.font = FontType.buttonLarge
		startedButton.backgroundColor = .brandOrange
		startedButton.layer.cornerRadius = Constraint.xSmall
		startedButton.heightAnchor.constraint(equalToConstant: Constraint.xHuge).isActive = true
		startedButton.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
		return startedButton
	}()
	
	//MARK: - Init
	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Colors.background
		setupUI()
	}
	
	//MARK: - SetupFuncs
	private func setupUI() {
		[backgroundImageView, titleLabel, descriptionLabel, getStartedButton].forEach {
			view.addSubview($0)
		}
		
		NSLayoutConstraint.activate([
			// BackgroundImage
			backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Constraint.mega),
			backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
			
			// Button
			getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constraint.medium),
			getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraint.medium),
			getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraint.medium),
			
			// Description
			descriptionLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -Constraint.medium),
			descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraint.medium),
			descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraint.medium),
			
			// Title
			titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -Constraint.medium),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraint.medium),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constraint.medium)
		])
	}
	
	//MARK: - TapButtonFunc
	@objc func didTapGetStarted() {
		userDefaults.set(true, forKey: onboardingCompletedKey)
		
		guard let window = view.window else { return }
		let homeViewController = HomeViewController()
		
		UIView.transition(with: window,
						  duration: AnimationDuration.medium,
						  options: .transitionCrossDissolve,
						  animations: {
			window.rootViewController = homeViewController
		}, completion: nil)
	}
}
