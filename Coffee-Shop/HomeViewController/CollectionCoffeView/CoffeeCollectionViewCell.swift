//
//  CoffeeCollectionViewCell.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

protocol CoffeeCollectionViewCellDelegate {
	func didTapButtonAction (in cell: CoffeeCollectionViewCell)
	func didSelectCoffeeCell (in cell: CoffeeCollectionViewCell)
}

class CoffeeCollectionViewCell: UICollectionViewCell {
	// MARK: - Properties
	static let reuseId = "CollectionCoffeCell"
	var itemID: Int?
	private let addButton = PrimaryButton(title: "+")
	var delegate: CoffeeCollectionViewCellDelegate?
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = Constraint.xSmall
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let starIcon: UIImageView = {
		let icon = UIImageView()
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.image = UIImage(named: "star")
		icon.contentMode = .scaleAspectFit
		return icon
	}()
	
	private let ratingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = .systemFont(ofSize: Constraint.xSmall, weight: .medium)
		label.numberOfLines = 1
		return label
	}()
	
	private let stackRating: UIStackView = {
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
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = FontType.mediumTitle
		label.numberOfLines = 1
		return label
	}()
	
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.secondaryText
		label.font = FontType.body
		label.numberOfLines = 1
		return label
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = FontType.body
		return label
	}()
	
	private let stackPriceAndButton: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = Constraint.tiny
		stack.distribution = .equalSpacing
		stack.alignment = .center
		return stack
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.backgroundColor = Colors.mainBackground
		contentView.layer.cornerRadius = Constraint.xSmall
		setupCellView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupCellView() {
		contentView.addSubview(imageView)
		contentView.addSubview(stackRating)
		contentView.addSubview(titleLabel)
		contentView.addSubview(subtitleLabel)
		contentView.addSubview(stackPriceAndButton)
		stackRating.addArrangedSubview(starIcon)
		stackRating.addArrangedSubview(ratingLabel)
		stackPriceAndButton.addArrangedSubview(priceLabel)
		stackPriceAndButton.addArrangedSubview(addButton)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.tiny),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.tiny),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraint.tiny),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
			
			stackRating.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.tiny),
			stackRating.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraint.tiny),
			starIcon.widthAnchor.constraint(equalToConstant: Constraint.xSmall),
			starIcon.heightAnchor.constraint(equalToConstant: Constraint.xSmall),
			
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraint.xxSmall),
			titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
			
			subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constraint.xTiny),
			subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
			
			stackPriceAndButton.topAnchor.constraint(greaterThanOrEqualTo: subtitleLabel.bottomAnchor, constant: Constraint.tiny),
			stackPriceAndButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			stackPriceAndButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
			stackPriceAndButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraint.xxSmall),
			
			addButton.widthAnchor.constraint(equalToConstant: Constraint.large),
			addButton.heightAnchor.constraint(equalToConstant: Constraint.large)
		])
	}
	
	// MARK: - Configure
	func configure(with item: CollectionViewCellViewModel) {
		itemID = item.id
		ratingLabel.text = item.ratingLabel
		titleLabel.text = item.titleLabel
		subtitleLabel.text = item.descriptionLabel
		priceLabel.text = item.priceLabel
		imageView.image = item.productImageView.image
		
		addButton.tapAction = {[weak self] in
			guard let self = self else { return }
			self.delegate?.didTapButtonAction(in: self)
		}
	}
}
