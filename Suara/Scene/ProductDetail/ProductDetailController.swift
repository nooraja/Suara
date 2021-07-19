//
//  ProductDetailController.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import UIKit

class ProductDetailController: UIViewController {
	
	lazy var coreDataHelper = CoreDataHelper()
	lazy var favoriteCoreData = ProductCoreData(mainContext: coreDataHelper.mainContext, coreDataHelper: coreDataHelper)
	
	let productImage: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	var titleLabel: UILabel = {
		let label: UILabel = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 24.0)
		label.numberOfLines = 0
		label.textAlignment = .left
		label.text = "-"
		return label
	}()
	
	lazy var likeIcon: UIImageView = {
		let img = UIImageView()
		img.contentMode = .scaleAspectFit
		return img
	}()
	
	var descLabel: UILabel = {
		let label: UILabel = UILabel()
		label.clipsToBounds = true
		label.numberOfLines = 0
		label.text = ""
		return label
	}()
	
	var addButton: UIButton = {
		let button = UIButton()
		button.layer.borderColor = UIColor.orange.cgColor
		button.layer.backgroundColor = UIColor.orange.cgColor
		button.layer.cornerRadius = 5
		button.layer.borderWidth = 2
		button.layer.masksToBounds = true
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = .orange
		button.setTitle("Buy", for: .normal)
		button.addTarget(self, action: #selector(whenTappedOrderButton), for: .touchUpInside)
		return button
	}()
	
	var priceLabel: UILabel = {
		let label: UILabel = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 16.0)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.text = "-"
		return label
	}()
	
	lazy var scrollView: UIScrollView = {
		let view = UIScrollView()
		view.backgroundColor = .clear
		view.bounces = true
		view.addSubview(productImage)
		view.addSubview(titleLabel)
		view.addSubview(likeIcon)
		view.addSubview(descLabel)
		view.addSubview(addButton)
		view.addSubview(priceLabel)
		
		let width = UIScreen.main.bounds.width
		productImage.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, width: width, height: width)
		
		titleLabel.anchor(top: productImage.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16, height: 40)
		
		likeIcon.anchor(top: productImage.bottomAnchor, left: titleLabel.rightAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 40)
		
		descLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
		
		addButton.anchor(top: descLabel.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingBottom: 16, paddingRight: 16, width: 80, height: 40)
		
		priceLabel.anchor(top: descLabel.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: addButton.leftAnchor, paddingTop: 16, paddingBottom: 16, paddingRight: 16, width: 80, height: 40)
		
		
		return view
	}()
	
	var product: Product!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configure()
	}
	
	func setupView() {
		
		let shareImage = UIImage(systemName: "square.and.arrow.up")
		self.navigationController?.navigationBar.backIndicatorImage = shareImage
		self.navigationController?.navigationBar.tintColor = .black
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: shareImage, style: .plain, target: self, action: #selector(whenTappedSharedButton))
		view.backgroundColor = .white
		view.addSubview(scrollView)
		
		scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
	}
	
	private func configure() {
		titleLabel.text = product.title
		productImage.loadImage(ath: product.imageURL)
		
		likeIcon.image = product.loved == 1 ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
		
		descLabel.text = product.productPromoDescription
		priceLabel.text = product.price
	}
	
	
	@objc func whenTappedSharedButton() {
		let objectsToShare = ["Please, check this \(product?.title ?? "")"] as [Any]
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		
		self.present(activityVC, animated: true, completion: nil)
	}
	
	@objc func whenTappedOrderButton() {
		let product = Product(id: product.id, price: product.price, title: product.title, desc: product.productPromoDescription, loved: 1, imageUrl: product.imageURL)
		
		favoriteCoreData.addProductToFavorite(product: product)
		self.navigationController?.popViewController(animated: false)
	}
}
