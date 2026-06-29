//
//  ScrollContainerView.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class ScrollContainerView: UIView {
	enum ScrollDirection {
		case vertical
		case horizontal
	}
	
	private let direction: ScrollDirection
	
	private let scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.alwaysBounceVertical = true
		scroll.showsVerticalScrollIndicator = false
		return scroll
	}()
	
	let contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	init(direction: ScrollDirection) {
		self.direction = direction
		super.init(frame: .zero)
		setupUIScrollView()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUIScrollView() {
		addSubview(scrollView)
		scrollView.addSubview(contentView)
		translatesAutoresizingMaskIntoConstraints = false
		
		switch direction {
		case .vertical:
			scrollView.alwaysBounceVertical = true
			scrollView.showsVerticalScrollIndicator = false
		case .horizontal:
			scrollView.alwaysBounceHorizontal = true
			scrollView.showsHorizontalScrollIndicator = false
		}
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
		])
		
		switch direction {
		case .vertical:
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
		case .horizontal:
			contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true
		}
	}
}
