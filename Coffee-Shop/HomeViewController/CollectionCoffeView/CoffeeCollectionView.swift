//
//  CoffeeCollectionView.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 30.04.2026.
//

import UIKit

class CoffeeCollectionView: UICollectionView {
	//MARK: - Properties
	private var listCellModel: [CollectionViewCellViewModel] = []
	var cellDelegate: CoffeeCollectionViewCellDelegate?
	
	private var layoutView: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top:  Constraint.xSmall,
										   left:  Constraint.xSmall,
										   bottom:  Constraint.xSmall,
										   right:  Constraint.xSmall)
		layout.minimumLineSpacing = Constraint.xSmall
		layout.minimumInteritemSpacing = Constraint.xSmall
		
		return layout
	}()
	
	//MARK: - Init
	init(frame: CGRect = .zero) {
		super.init(frame: frame, collectionViewLayout: layoutView)
		setupCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Setup
	private func setupCollectionView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.delegate = self
		self.dataSource = self
		
		self.register(CoffeeCollectionViewCell.self, forCellWithReuseIdentifier: CoffeeCollectionViewCell.reuseId)
	}
	
	//MARK: - UpdateData
	func updateData(with models: [CollectionViewCellViewModel]) {
		self.listCellModel = models
		self.reloadData()
		
		UIView.transition(
			with: self,
			duration: AnimationDuration.medium,
			options: .transitionCrossDissolve,
			animations: {
				self.reloadData()
			},
			completion: nil
		)
	}
}

	//MARK: - Extension
extension CoffeeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.listCellModel.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoffeeCollectionViewCell.reuseId, for: indexPath) as? CoffeeCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		let viewModel = listCellModel[indexPath.item]
		cell.configure(with: viewModel)
		
		cell.delegate = self.cellDelegate
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? CoffeeCollectionViewCell {
			cellDelegate?.didSelectCoffeeCell(in: cell)
		}
	}
}

extension CoffeeCollectionView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widthView = collectionView.bounds.width
			let totalInsets = Constraint.xSmall * 2
			let spacing = Constraint.xSmall
			let targetWidth = (widthView - spacing - totalInsets) / 2
			let sizingCell = CoffeeCollectionViewCell()
		
			let viewModel = listCellModel[indexPath.item]
			sizingCell.configure(with: viewModel)
		
			let targetSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)
			let autoSize = sizingCell.contentView.systemLayoutSizeFitting(
				targetSize,
				withHorizontalFittingPriority: .required,
				verticalFittingPriority: .fittingSizeLevel
			)
			
			return CGSize(width: targetWidth, height: autoSize.height)
	}
}
