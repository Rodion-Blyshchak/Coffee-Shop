//
//  SearchBarView.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

protocol SearchBarViewDelegate {
	func searchBarView(_ searchBarView: SearchBarView, didChangeSearchText text: String)
}

class SearchBarView: UIView {
	//MARK: - Properties
	var delegate: SearchBarViewDelegate?
	
	private let searchBar: UISearchBar = {
		let searshBar = UISearchBar()
		searshBar.translatesAutoresizingMaskIntoConstraints = false
		searshBar.placeholder = "Search coffee..."
		searshBar.searchBarStyle = .minimal
		return searshBar
	}()
	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Setup
	private func setupView() {
		addSubview(searchBar)
		searchBar.delegate = self
		
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
			searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

//MARK: - Extension
extension SearchBarView: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		delegate?.searchBarView(self, didChangeSearchText: searchText)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}
