//
//  FooterContentBlockView.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class FooterContentBlockView: UIView {
	//MARK: - Properties
	private let button = PrimaryButton(title: "")
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.secondaryText
		label.font = FontType.body
		label.numberOfLines = 1
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.brandOrange
		label.font = FontType.mediumTitle
		label.numberOfLines = 0
		return label
	}()
	
	private let labelStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = Constraint.tiny
		stack.axis = .vertical
		stack.alignment = .center
		stack.alignment = .leading
		return stack
	}()
	
	private let containerStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.spacing = Constraint.small
		return stack
	}()
	
	// MARK: - Init
	init(title: String, description: Double, buttonLabel: String, axis: NSLayoutConstraint.Axis = .vertical) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = Colors.mainBackground
		layer.cornerRadius = Constraint.xSmall
		layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		
		titleLabel.text = title
		descriptionLabel.text = "$ \(description)"
		button.updateTitle(buttonLabel)
		
		containerStackView.alignment = (axis == .horizontal) ? .center : .fill
		containerStackView.distribution = (axis == .horizontal) ? .equalSpacing : .fill
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setup() {
		addSubview(containerStackView)
		
		labelStackView.addArrangedSubview(titleLabel)
		labelStackView.addArrangedSubview(descriptionLabel)
		
		containerStackView.addArrangedSubview(labelStackView)
		containerStackView.addArrangedSubview(button)
		
		NSLayoutConstraint.activate([
			containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constraint.small),
			containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraint.small),
			containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constraint.small),
			containerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
			
			button.heightAnchor.constraint(equalToConstant: 56),
			button.widthAnchor.constraint(equalToConstant: 217)
		])
	}
	
	// MARK: - Update
	func updateTitle(title: String, description: String,  buttonLabel: String) {
		titleLabel.text = title
		descriptionLabel.text = description
		button.updateTitle(buttonLabel)
	}
}
