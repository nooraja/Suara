//
//  SearchCell.swift
//  Suara
//
//  Created by Muhammad Noor on 19/07/21.
//

import UIKit

class SearchCell: UITableViewCell {
	
	lazy var titleLabel = UILabel()
	
	lazy var priceLabel = UILabel()
	
	lazy var productImage: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.selectionStyle = .none
		contentView.addSubview(productImage)
		
		[titleLabel, priceLabel].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			$0.textColor = .black
			$0.numberOfLines = 1
			$0.textAlignment = .left
			$0.font = .systemFont(ofSize: 14)
			contentView.addSubview($0)
		}
		
		productImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, width: 50, height: 50)
		
		titleLabel.anchor(top: contentView.topAnchor, left: productImage.rightAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, height: 20)
		
		priceLabel.anchor(top: titleLabel.bottomAnchor, left: productImage.rightAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, height: 20)
		
	}
	
	func configure(_ product: Product){
		titleLabel.text = product.title
		productImage.loadImage(ath: product.imageURL)
		priceLabel.text = product.price
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
