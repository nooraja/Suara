//
//  FeedCell.swift
//  Suara
//
//  Created by Muhammad Noor on 18/07/21.
//

import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14)
		return label
	}()
	
	lazy var mediaImage: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	lazy var likeIcon: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(titleLabel)
		addSubview(mediaImage)
		addSubview(likeIcon)
		
		titleLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, height: 30)
		mediaImage.anchor(top: topAnchor, left: leftAnchor, bottom: titleLabel.topAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
		likeIcon.anchor(left: mediaImage.leftAnchor, bottom: mediaImage.bottomAnchor, width: 30, height: 30)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func configure(product: Product) {
		titleLabel.text = product.title
		mediaImage.loadImage(ath: product.imageURL)
		
		likeIcon.image = product.loved == 1 ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
	}
}
