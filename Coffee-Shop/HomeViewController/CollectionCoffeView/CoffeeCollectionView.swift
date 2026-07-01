//
//  CoffeeCollectionView.swift
//  Coffee-Shop
//
//  Created by Rodion Blyshchak on 30.04.2026.
//

import UIKit

class CoffeeCollectionView: UICollectionView {
	//MARK: - Properties
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
		translatesAutoresizingMaskIntoConstraints = false
		
		self.register(CoffeeCollectionViewCell.self, forCellWithReuseIdentifier: CoffeeCollectionViewCell.reuseId)
	}
	
	//MARK: - UpdateData
	func updateData() {
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
