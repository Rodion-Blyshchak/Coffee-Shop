//
//  DetailCardViewController.swift
//  Coffee-Shop
//
//  Crafted by Rodion Blyshchak on 2026
//

import UIKit

class DetailCardViewController: UIViewController {
	//MARK: - Properties
	var viewModel: DetailCardViewModel?
	private let verticalScroll = ScrollContainerView(direction: .vertical)
	private let addButton = PrimaryButton(title: "Buy Now")
	private let ratingStackView = RatingView(rating: 0.0)
	private var footerPurchaseView: FooterContentBlockView?
	
	private let imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = Constraint.xxSmall
		return image
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
		label.numberOfLines = 3
		return label
	}()
	
	private let dividerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Colors.secondaryText
		return view
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.primaryText
		label.font = FontType.mediumTitle
		label.text = "Description"
		return label
	}()
	
	private let descriptionContentLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = Colors.secondaryText
		label.font = FontType.body
		label.numberOfLines = 0
		return label
	}()
	
	// MARK: - Init
	init() {
		super.init(nibName: nil, bundle: nil)
		self.hidesBottomBarWhenPushed = true  // Приховує таббар
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = Colors.background
		
		setupFooterView()
		setupScrollView()
		setup()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
		
		let appearance = UINavigationBarAppearance()
		appearance.titleTextAttributes = [
			.foregroundColor: Colors.primaryText,
			.font: FontType.largeTitle
		]
		
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		
		setupFaforiteButton()
	}
	
	//MARK: - Setup
	private func setupFooterView() {
		guard let viewModel else { return }
		
		let footer = FooterContentBlockView(
			title: viewModel.titlePrice,
			description: viewModel.price,
			buttonLabel: "Buy Now",
			axis: .horizontal
		)
		
		view.addSubview(footer)
		footerPurchaseView = footer
		
		NSLayoutConstraint.activate([
			footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
		])
	}
	
	private func setupScrollView() {
		view.addSubview(verticalScroll)
		
		guard let footer = footerPurchaseView else { return }
		
		NSLayoutConstraint.activate([
			verticalScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			verticalScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			verticalScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			verticalScroll.bottomAnchor.constraint(equalTo: footer.topAnchor)
		])
	}
	
	private func setup() {
		ratingStackView.translatesAutoresizingMaskIntoConstraints = false
		
		verticalScroll.contentView.addSubview(imageView)
		verticalScroll.contentView.addSubview(titleLabel)
		verticalScroll.contentView.addSubview(ratingStackView)
		verticalScroll.contentView.addSubview(subtitleLabel)
		verticalScroll.contentView.addSubview(dividerView)
		verticalScroll.contentView.addSubview(descriptionLabel)
		verticalScroll.contentView.addSubview(descriptionContentLabel)
		
		guard let viewModel else { return }

		self.title = viewModel.title
		imageView.image = viewModel.productImageView
		titleLabel.text = viewModel.title
		subtitleLabel.text = viewModel.subtitle
		ratingStackView.updateRating(Double(viewModel.rating))
		descriptionContentLabel.text = viewModel.descriptionContent
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: verticalScroll.contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor, constant: Constraint.small),
			imageView.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor, constant: -Constraint.small),
			imageView.heightAnchor.constraint(equalToConstant: ScreenSizeHelper.heightMultiplier(0.25)),
			
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraint.small),
			titleLabel.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor, constant: Constraint.small),
			titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingStackView.leadingAnchor, constant: -Constraint.small),
			
			ratingStackView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
			ratingStackView.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor, constant: -Constraint.small),
			
			subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constraint.xTiny),
			subtitleLabel.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor, constant: Constraint.small),
			subtitleLabel.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor, constant: -Constraint.small),
			
			dividerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constraint.small),
			dividerView.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor, constant: Constraint.small),
			dividerView.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor, constant: -Constraint.small),
			dividerView.heightAnchor.constraint(equalToConstant: 1),
			
			descriptionLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: Constraint.small),
			descriptionLabel.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor, constant: Constraint.small),
			descriptionLabel.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor, constant: -Constraint.small),
			
			descriptionContentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constraint.xTiny),
			descriptionContentLabel.leadingAnchor.constraint(equalTo: verticalScroll.contentView.leadingAnchor, constant: Constraint.small),
			descriptionContentLabel.trailingAnchor.constraint(equalTo: verticalScroll.contentView.trailingAnchor, constant: -Constraint.small),
			
			descriptionContentLabel.bottomAnchor.constraint(equalTo: verticalScroll.contentView.bottomAnchor, constant: -Constraint.small)
		])
	}
	
	private func setupFaforiteButton() {
		let faforiteButton = CustomIconButton(image: UIImage(named: "Faforite"))
		
		NSLayoutConstraint.activate([
			faforiteButton.widthAnchor.constraint(equalToConstant: Constraint.xxxLarge),
			faforiteButton.heightAnchor.constraint(equalToConstant: Constraint.xxxLarge)
		])
		
		faforiteButton.tapAction = {
			print("Клік на серце!")
		}
		
		let faforiteBarButtonItem = UIBarButtonItem(customView: faforiteButton)
		self.navigationItem.rightBarButtonItem = faforiteBarButtonItem
	}
}
