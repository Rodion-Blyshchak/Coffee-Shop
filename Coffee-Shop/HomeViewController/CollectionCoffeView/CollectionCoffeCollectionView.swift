//
//  CollectionCoffeCollectionView.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 30.04.2026.
//

import UIKit

class CollectionCoffeCollectionView: UICollectionView {
	private let listCellModel: [CollectionViewCellViewModel] = [
		CollectionViewCellViewModel(
			id: 1,
			productImageView: UIImageView(image: UIImage(named: "DefaultBannerImage")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: "4.8",
			titleLabel: "Caffe Mocha",
			descriptionLabel: "Deep Foam",
			priceLabel: "$ 4.53"
		),
		CollectionViewCellViewModel(
			id: 2,
			productImageView: UIImageView(image: UIImage(named: "bannerMorningEspresso")),
			starIcon: UIImageView(image: UIImage(systemName: "star.fill")),
			ratingLabel: "4.8",
			titleLabel: "Caffe Mocha",
			descriptionLabel: "Deep Foam",
			priceLabel: "$ 4.53"
		)
	]
	
	init() {
		// Тут насправді питання чи норм практика ось так оголошувати layout у init()?
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top:  Constraint.xSmall,
										   left:  Constraint.xSmall,
										   bottom:  Constraint.xSmall,
										   right:  Constraint.xSmall)
		layout.minimumLineSpacing = Constraint.xSmall
		layout.minimumInteritemSpacing = Constraint.xSmall
		super.init(frame: .zero, collectionViewLayout: layout)
		
		setupCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCollectionView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.delegate = self
		self.dataSource = self
		
		self.register(CollectionCoffeCellCollectionView.self, forCellWithReuseIdentifier: CollectionCoffeCellCollectionView.reuseId)
	}
}

extension CollectionCoffeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.listCellModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCoffeCellCollectionView.reuseId, for: indexPath) as? CollectionCoffeCellCollectionView else {
			return UICollectionViewCell()
		}
		
		let viewModel = listCellModel[indexPath.item]
		cell.configure(with: viewModel)
		
		return cell
	}
}

extension CollectionCoffeCollectionView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widthView = collectionView.bounds.width
		let totalInsets: Int = 16 + 16
		let spacing = Constraint.xSmall
		
		return CGSize(width: (Int(widthView) - Int(spacing) - totalInsets) / 2, height: 260)
	}
}
