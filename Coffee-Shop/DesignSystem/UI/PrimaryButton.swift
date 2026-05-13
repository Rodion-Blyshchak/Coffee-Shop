//
//  PrimaryButton.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class PrimaryButton: UIButton {
	var tapAction: (() -> Void)?
	
	// MARK: - Init
	init(title: String) {
		super.init(frame: .zero)
		setTitle(title, for: .normal)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupButton() {
		backgroundColor = Colors.brandOrange
		setTitleColor(.white, for: .normal)
		titleLabel?.font = .sora(size: Constraint.xSmall, weight: .extraBold)
		layer.cornerRadius = 10
		translatesAutoresizingMaskIntoConstraints = false
		
		addTarget(self, action: #selector(handleTap), for: .touchUpInside)
	}
	
	@objc private func handleTap() {
		tapAction?()
		UIView.animate(withDuration: 0.1, animations: {
			self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
		}) { _ in
			UIView.animate(withDuration: 0.1) {
				self.transform = .identity
			}
		}
	}
}
