//
//  OnboardingViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 11.04.2026.
//

import UIKit

class OnboardingViewController: UIViewController {
	enum ConstantsSize {
		static let mainIndent: CGFloat = 24
		static let negativeMainIndent: CGFloat = -24
		static let fontTitle: CGFloat = 38
		static let fontSubTitle: CGFloat = 18
		static let cornerRadius: CGFloat = 16
		static let numberOfLines: Int = 0
	}
	
	//MARK: - Properties
	private let storageManager: OnboardingStorageManagerProtocol
	
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
		title.font = .sora(size: ConstantsSize.fontTitle, weight: .semiBold)
		title.textColor = .appWhite
		title.numberOfLines = ConstantsSize.numberOfLines
		title.textAlignment = .center
		return title
	}()
	
	private let descriptionLabel: UILabel = {
		let description = UILabel()
		description.translatesAutoresizingMaskIntoConstraints = false
		description.text = "Welcome to our cozy coffee corner, where every cup is a delightful for you."
		description.font = .sora(size: ConstantsSize.fontSubTitle, weight: .regular)
		description.textColor = .appLightGrey
		description.numberOfLines = ConstantsSize.numberOfLines
		description.textAlignment = .center
		return description
	}()
	
	private let getStartedButton: UIButton = {
		let startedButton = UIButton()
		startedButton.translatesAutoresizingMaskIntoConstraints = false
		startedButton.setTitle("Get Started", for: .normal)
		startedButton.setTitleColor(.appWhite, for: .normal)
		startedButton.titleLabel?.font = .sora(size: ConstantsSize.fontSubTitle, weight: .semiBold)
		startedButton.backgroundColor = .brandOrange
		startedButton.layer.cornerRadius = ConstantsSize.cornerRadius
		startedButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
		startedButton.addTarget(self, action: #selector(didTapGetStarted), for: .touchUpInside)
		return startedButton
	}()
	
	//MARK: - Init
	init(storageManager: OnboardingStorageManagerProtocol) {
		self.storageManager = storageManager
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	//MARK: - SetupFuncs
	private func setupUI() {
		[backgroundImageView, titleLabel, descriptionLabel, getStartedButton].forEach {
			view.addSubview($0)
		}
		
		NSLayoutConstraint.activate([
			// BackgroundImage
			backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			// Button
			getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: ConstantsSize.negativeMainIndent),
			getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			
			// Description
			descriptionLabel.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: ConstantsSize.negativeMainIndent),
			descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			
			// Title
			titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: ConstantsSize.negativeMainIndent),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsSize.mainIndent),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	//MARK: - TapButtonFunc
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
