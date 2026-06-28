//
//  RatingView.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class RatingView: UIView {
	// MARK: - Properties
	private let starIconImageView: UIImageView = {
		let icon = UIImageView()
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.image = UIImage(named: "star")
		icon.contentMode = .scaleAspectFit
		return icon
	}()
	
	private let ratingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.white
		label.font = .systemFont(ofSize: Constraint.xSmall, weight: .medium)
		label.numberOfLines = 1
		return label
	}()
	
	private let ratingStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = Constraint.xTiny
		stack.alignment = .center
		stack.backgroundColor = UIColor.black.withAlphaComponent(Opacity.half)
		stack.layer.cornerRadius = Constraint.xSmall
		stack.clipsToBounds = true
		stack.isLayoutMarginsRelativeArrangement = true
		stack.layoutMargins = UIEdgeInsets(top: Constraint.xTiny, left: Constraint.xTiny, bottom: Constraint.xTiny, right: Constraint.xTiny)
		return stack
	}()
	
	// MARK: - Init
	init (rating: Double, textColor: UIColor = Colors.white) {
		super.init(frame: .zero)
		
		ratingLabel.text = "\(rating)"
		ratingLabel.textColor = textColor
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setup() {
		addSubview(ratingStackView)
		ratingStackView.addArrangedSubview(starIconImageView)
		ratingStackView.addArrangedSubview(ratingLabel)
		
		NSLayoutConstraint.activate([
			ratingStackView.topAnchor.constraint(equalTo: topAnchor),
			ratingStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			ratingStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			ratingStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			starIconImageView.widthAnchor.constraint(equalToConstant: Constraint.xSmall),
			starIconImageView.heightAnchor.constraint(equalToConstant: Constraint.xSmall),
		])
	}
	
	// MARK: - Update
	func updateRating(_ newRating: Double) {
		ratingLabel.text = "\(newRating)"
	}
}

//let badgeRating = RatingView(rating: "4.8")
