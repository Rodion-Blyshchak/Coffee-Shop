//
//  BannerViewController.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 16.04.2026.
//

import UIKit

class BannerViewController: UIViewController {
	
	// MARK: - Properties
	private var timer: Timer?
	private var currentIndex = 0
	private let defaultBannerImage = UIImage(named: "DefaultBannerImage") ?? UIImage()
	
	private lazy var mockData: [BannerModel] = [
		BannerModel(image: UIImage(named: "bannerCoffeeCup") ?? defaultBannerImage,
					title: "Feel the Magic of Real Coffee"),
		BannerModel(image: UIImage(named: "bannerCozyTable") ?? defaultBannerImage,
					title: "Cozy Vibe in Every Detail of Our Interior"),
		BannerModel(image: UIImage(named: "bannerMorningEspresso") ?? defaultBannerImage,
					title: "The Perfect Start to Your Productive Morning"),
		BannerModel(image: UIImage(named: "bannerTraditionalBrew") ?? defaultBannerImage,
					title: "Traditional Brewing Methods in Every Cup")
	]
	
	// MARK: - UI Elements
	private let bannerImageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.layer.cornerRadius = Constraint.xSmall
		iv.translatesAutoresizingMaskIntoConstraints = false
		return iv
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = FontType.mediumTitle
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		updateBannerData()
		setupGesture()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		startTimer()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		stopTimer()
	}
	
	// MARK: - Setup
	private func setupUI() {
		view.addSubview(bannerImageView)
		bannerImageView.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([ // TODO: - поправити
			bannerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			bannerImageView.heightAnchor.constraint(equalToConstant: 140),
			
			titleLabel.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor, constant: 16),
			titleLabel.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -16),
			titleLabel.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: -100)
									])
	}
	
	// MARK: - Logic
	private func startTimer() {
		stopTimer() // На всякий випадок зупиняю старий
		timer = Timer.scheduledTimer(withTimeInterval: AnimationDuration.infinite, repeats: true) { _ in
			self.showNextBanner()
		}
	}
	
	private func stopTimer() {
		timer?.invalidate()
		timer = nil
	}
	
	private func showNextBanner() {
		currentIndex = (currentIndex + 1) % mockData.count
		
		UIView.transition(with: bannerImageView,
						  duration: AnimationDuration.slow,
						  options: .transitionCrossDissolve,
						  animations: {
			self.updateBannerData()
		}, completion: nil)
	}
	
	private func updateBannerData() {
		let currentBanner = mockData[currentIndex]
		bannerImageView.image = currentBanner.image
		titleLabel.text = currentBanner.title
	}
	
	// Стопання анімації при дотика на банер
	private func setupGesture() {
		bannerImageView.isUserInteractionEnabled = true
		
		let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
		longPress.minimumPressDuration = 0
		bannerImageView.addGestureRecognizer(longPress)
	}
	
	@objc func handleLongPress(sender: UILongPressGestureRecognizer) {
		switch sender.state {
		case .began:
			stopTimer()
		case .ended, .cancelled, .failed:
			startTimer()
		default:
			break
		}
	}
}
