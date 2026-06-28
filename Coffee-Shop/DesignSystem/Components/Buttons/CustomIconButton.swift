//
//  CustomIconButton.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class CustomIconButton: UIButton {
	var tapAction: (() -> Void)?
	
	// MARK: - Init
	init(image: UIImage?, tintColor: UIColor = Colors.primaryText) {
		super.init(frame: .zero)
		setImage(image, for: .normal)
		self.tintColor = tintColor
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupButton() {
		translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .clear
		
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
	
	func setSelected(_ isSelected: Bool) {
		if isSelected {
			backgroundColor = Colors.brandOrange
			setTitleColor(Colors.white, for: .normal)
		} else {
			backgroundColor = Colors.mainBackground
			setTitleColor(Colors.secondaryText, for: .normal)
		}
	}
}
