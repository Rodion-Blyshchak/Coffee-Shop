//
//  CategoryFilterView.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

protocol CategoryFilterViewDelegate: AnyObject {
	func categoryFilterView(_ filterView: CategoryFilterView, didSelectCategory category: String)
}

class CategoryFilterView: UIScrollView {
	var filterDelegate: CategoryFilterViewDelegate?
	
	private var categories: [String] = []
	private var buttons: [UIButton] = []
	private var selectedCategory: String = "All Coffee"
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.spacing = Constraint.tiny
		stack.alignment = .center
		return stack
	}()
	
	init() {
		super.init(frame: .zero)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		showsHorizontalScrollIndicator = false
		contentInset = UIEdgeInsets(top: 0, left: Constraint.xSmall, bottom: 0, right: Constraint.xSmall)
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
//			stackView.heightAnchor.constraint(equalTo: frameLayoutGuide.heightAnchor)
		])
	}
	
	func updateCategories(newCategories: [String]) {
		categories = newCategories
		
		// На всякий тут видаляю старі кнопки
		buttons.forEach{ $0.removeFromSuperview() }
		buttons.removeAll()
		
		for (index, category) in categories.enumerated() {
			let button = PrimaryButton(title: category)
			let isSelected = index == 0
			button.setSelected(isSelected)
			
			button.tapAction = { [weak self, weak button] in
				guard let self = self, let button = button else { return }
				self.categoryButtonTapped(button)
			}
			
			stackView.addArrangedSubview(button)
			buttons.append(button)
		}
		
		selectedCategory = categories.first ?? "All Coffee"
	}
	
	private func categoryButtonTapped(_ sender: PrimaryButton) {
		guard let categoryTitle = sender.title(for: .normal) else { return }
		
		selectedCategory = categoryTitle
		
		for button in buttons {
			if let customButton = button as? PrimaryButton {
				let isSelected = customButton == sender
				customButton.setSelected(isSelected)
			}
		}
		
		let rectToVisible = CGRect(
			x: sender.frame.origin.x,
			y: sender.frame.origin.y,
			width: sender.frame.size.width,
			height: sender.frame.size.height
		)
		
		self.scrollRectToVisible(rectToVisible, animated: true)
		
		filterDelegate?.categoryFilterView(self, didSelectCategory: categoryTitle)
	}
}
