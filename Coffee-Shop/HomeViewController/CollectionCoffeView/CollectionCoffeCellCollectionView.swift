//
//  CollectionCoffeCellCollectionView.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class CollectionCoffeCellCollectionView: UICollectionViewCell {
	// MARK: - Properties
	static let reuseId = "CollectionCoffeCell"
	var itemID: Int?
	private let addButton = PrimaryButton(title: "+")
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = Constraint.xSmall
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = .systemFont(ofSize: 20, weight: .medium)
		label.numberOfLines = 0
		return label
	}()
	
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.secondaryText
		label.font = .systemFont(ofSize: 16, weight: .medium)
		label.numberOfLines = 0
		return label
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = .systemFont(ofSize: 16, weight: .medium)
		return label
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCellView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	private func setupCellView() {
		contentView.addSubview(imageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(subtitleLabel)
		contentView.addSubview(priceLabel)
		contentView.addSubview(addButton)
		
		NSLayoutConstraint.activate([
			// Тут поки просто виводжу як є. Трохи пізніше виправлю
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
			imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
			
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			
			subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
			subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			
			priceLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
			priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
			priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
			
			addButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
			addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			addButton.widthAnchor.constraint(equalToConstant: 32),
			addButton.heightAnchor.constraint(equalToConstant: 32)
		])
	}
	
	// MARK: - Configure
	func configure(with item: CollectionViewCellViewModel) {
		itemID = item.id
		titleLabel.text = item.titleLabel
		subtitleLabel.text = item.descriptionLabel
		priceLabel.text = item.priceLabel
		imageView.image = item.productImageView.image
		
		addButton.tapAction = {
			print("+")
		}
	}
}
