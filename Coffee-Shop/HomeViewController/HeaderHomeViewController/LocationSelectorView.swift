//
//  LocationSelectorView.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 24.04.2026.
//

import UIKit

protocol LocationSelectorDelegate {
	func didTapLocationSelector()
}

class LocationSelectorView: UIView {
	// MARK: - Properties
	var delegate: LocationSelectorDelegate?
	
	private let stackLocationSelectorView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = Constraint.xTiny
		stackView.alignment = .leading
		return stackView
	}()
	
	private let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.lightGrey
		label.font = FontType.mediumTitle
		label.text = "Location"
		return label
	}()
	
	private let horizontalStackkLocation: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = Constraint.xTiny
		stackView.alignment = .center
		return stackView
	}()
	
	private let locationLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.lightGrey
		label.font = FontType.body
		label.text = "Select a city"
		return label
	}()
	
	private let dropdownIconView: UIImageView = {
		let icon = UIImageView()
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.image = UIImage(systemName: "chevron.down")
		icon.tintColor = Colors.lightGrey
		icon.widthAnchor.constraint(equalToConstant: Constraint.xSmall).isActive = true
		icon.heightAnchor.constraint(equalToConstant: Constraint.xSmall).isActive = true
		return icon
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLocationSelectorView()
		setupGesture()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupLocationSelectorView() {
		addSubview(stackLocationSelectorView)
		stackLocationSelectorView.addArrangedSubview(label)
		stackLocationSelectorView.addArrangedSubview(horizontalStackkLocation)
		
		horizontalStackkLocation.addArrangedSubview(locationLabel)
		horizontalStackkLocation.addArrangedSubview(dropdownIconView)
		
		NSLayoutConstraint.activate([
			stackLocationSelectorView.topAnchor.constraint(equalTo: topAnchor),
			stackLocationSelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraint.small),
			stackLocationSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraint.small),
			stackLocationSelectorView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	// MARK: - setupGesture
	private func setupGesture() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
		self.addGestureRecognizer(tap)
		self.isUserInteractionEnabled = true
	}
	
	@objc private func didTap() {
		delegate?.didTapLocationSelector()
	}
	
	func updateLocationText(to city: String) {
		UIView.animate(withDuration: AnimationDuration.fast, animations: {
			self.locationLabel.alpha = 0
			self.dropdownIconView.alpha = 0
			self.horizontalStackkLocation.transform = CGAffineTransform(translationX: 0, y: 5)
		}) { _ in
			self.locationLabel.text = city
			
			UIView.animate(withDuration: AnimationDuration.medium) {
				self.locationLabel.alpha = 1
				self.dropdownIconView.alpha = 1
				self.horizontalStackkLocation.transform = .identity
			}
		}
	}
	
	func animateChevron(isOpened: Bool) {
		UIView.animate(withDuration: AnimationDuration.medium) {
			self.dropdownIconView.transform = isOpened ? CGAffineTransform(rotationAngle: .pi) : .identity
		}
	}
}
