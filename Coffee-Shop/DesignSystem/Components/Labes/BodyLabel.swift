//
//  BodyLabel.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class BodyLabel: UILabel {
	// MARK: - Properties
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = FontType.mediumTitle
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.secondaryText
		label.font = FontType.body
		return label
	}()
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = Constraint.xTiny
		stack.alignment = .fill
		stack.distribution = .fill
		return stack
	}()
	
	// MARK: - Init
	init(title: String? = nil, subtitle: String? = nil, titleLines: Int = 1, descriptionLines: Int = 0) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		
		titleLabel.text = title
		titleLabel.numberOfLines = titleLines
		descriptionLabel.text = subtitle
		descriptionLabel.numberOfLines = descriptionLines
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setup() {
		addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(descriptionLabel)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	// MARK: - Configure
	func configure(title: String?, subtitle: String?) {
		titleLabel.text = title
		descriptionLabel.text = subtitle
	}
}
